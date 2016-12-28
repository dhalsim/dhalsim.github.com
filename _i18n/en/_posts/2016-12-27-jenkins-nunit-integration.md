---
layout: post
title: "Jenkins NUnit Integration with Test and Coverage Reports"
description: "Create reports automatically when your build runs using Jenkins, NUnit and various other tools"
toc: true
category: ["build", "tooling"]
tags: ["jenkins", "nunit", "TDD", "CI"]
excerpt: "Create reports automatically when your build runs using Jenkins, NUnit and various other tools."
image: "/assets/images/jenkins-logo.png"
mermaid: true
---

{% include JB/setup %}

# Jenkins NUnit Integration

![jenlins](/assets/images/jenkins-logo.png)
![nunit](/assets/images/nunit-logo.png)

This integration contains:

* A CI job that runs NUnit tests and creates HTML reports after building a .NET project
* Installing HTML publish plugin
* Generating NUnit report with ReportUnit
* Generating code coverage report with OpenCover
* Generating code coverage HTML report with ReportUnit

But doesn't contain:

* How to install and Jenkins
* How to create a build job from scratch
* How to integrate source control managers
* How to write unit tests
* etc.

## Setup

This is a relatively easy to integrate NUnit and the reports. The tricky parts are installing the right tools and running them on the console. If you can accomplish that, Jenkins part is easy as I said.

### Step 1: Installing Nuget packages

Install these packages to your test project:

* [NUnit](https://www.nunit.org/)
* NUnit.ConsoleRunner
* [ReportUnit](https://github.com/reportunit/reportunit)
* [OpenCover](https://github.com/OpenCover/opencover)
* [ReportGenerator](https://github.com/danielpalme/ReportGenerator)

If you check your *packages* directory, you'll see these packages installed for example NUnit Console Runner is in:

`packages\NUnit.ConsoleRunner.X.X.X\tools\nunit3-console.exe`

> Write at least a few unit tests, and test the project using this exe from command line.

### Step 2: Create a bat executable

Create a `jenkins_unittests.bat` file in your project folder like this:

~~~bat
REM Path variables
SET FolderPath=%1
SET ResultsPath=C:\UnitTestResults
SET CoverageHistoryPath=C:\CoverageHistory

SET NunitPath=%FolderPath%\packages\NUnit.ConsoleRunner.3.5.0\tools
SET ReportUnitPath=%FolderPath%\packages\ReportUnit.1.5.0-beta1\tools
SET OpenCoverPath=%FolderPath%\packages\OpenCover.4.6.519\tools
SET ReportGeneratorPath=%FolderPath%\packages\ReportGenerator.2.4.5.0\tools

SET UnitTestProj=%FolderPath%\MyProject.UnitTests\MyProject.UnitTests.csproj

REM Recreate Results Folder
rd /S /Q %ResultsPath%
md %ResultsPath%

REM Create coverage history folder if not exists
if not exist "%CoverageHistoryPath%" mkdir %CoverageHistoryPath%

REM Run Nunit3 for tests, it produces TestResult.xml report
%NunitPath%\nunit3-console.exe %UnitTestProj% --result=%ResultsPath%\TestResult.xml

REM Get nunit command errorlevel
SET NunitError=%ERRORLEVEL%

REM Run ReportUnit to create HTML Report from Nunit XML report
%ReportUnitPath%\ReportUnit.exe %ResultsPath%\TestResult.xml

REM Run OpenCover to create coverage XML report
%OpenCoverPath%\OpenCover.Console.exe -register:user -register:user -target:%NunitPath%\nunit3-console.exe -targetargs:%UnitTestProj% -output:%ResultsPath%\opencovertests.xml

REM Run ReportGenerator to create coverage HTML report from coverage XML
%ReportGeneratorPath%\ReportGenerator.exe -reports:%ResultsPath%\opencovertests.xml -targetDir:%ResultsPath% -historydir:%CoverageHistoryPath%

REM Fail if Nunit has found an error on tests
exit /b %NunitError%
~~~

> You need to add this file to the source control as well. In this way jenkins could access the file after pulling (TFS: checkout) your source repository.

To update or maintain the script easily, I used some parameters and variables across the script. `%1` is the first (and only) parameter that we will use. We will pass the directory of our project that jenkins will use from the jenkins job.

> Please update the script as the right paths and versions of your packages. Also test project name must be changed according to yours.

### Step 3: Creating paths

I used these 2 folders for reports generated.

* `C:\UnitTestResults`
* `C:\CoverageHistory`

Create these folders on the computer jenkins runs.

### Step 4: Configuring Jenkins

You need these plugins or equivalents in order to make this integration

* A source control plugin (In my case it is Team Foundation Server Plugin)
* A build plugin (In my case it is MSBuild Plugin)
* HTML publisher plugin

Search and install these plugins from **Manage Jenkins** -> **Manage Plugins**

### Step 4: Create/Update your jenkins job

After you setup your jenkins job and see that your build is successful, we can go on and integrate the tests.

After the MSBuild step, you need to add a **Execute Windows batch command** step. Command will be:

```
[PATH_TO_YOUR_PROJECT_ROOT]\jenkins_unittest.bat [PATH_TO_YOUR_PROJECT_ROOT]
```

This way we will pass the project root as a parameter to the batch script.

Then we need to add two HTML reports from **Add post-build action** button, and selecting **Publish HTML reports**.

We need to add two reports by clicking the add button twice. First one will be the unit test report, and second will be the Coverage report.

Fill the forms with the appropriate values

1. First report
  * HTML directory to archive: `C:\UnitTestResults`
  * Index page[s]: TestResult.html
  * Report title: Unit Test Report
2. Second report
  * HTML directory to archive: `C:\CoverageHistory`
  * Index page[s]: index.htm
  * Report title: Code Coverage Report

> Select **Keep past HTML reports** and **Always link to last build** from **Publishing options**.

## Running

The basic flow is:

<div class="mermaid">
graph LR
    Start-- Unit test project -->nunit[Run Tests with NUnit]
    nunit-->TR[TestResult.xml]
    RU[ReportUnit.exe]-- TestResult.xml -->TReport[TestResult.html]
    OC[OpenCover]-- Unit test project<br />NUnit -->OCR[opencovertests.xml]
    RG[Report Generator]-- opencovertests.xml -->HTML[HTML Coverage Report]
</div>

You can also try to run each script separately to see how it works, or to troubleshoot. In each step an output file will be created. When nunit tests run, an XML file (we gave **TestResult.xml** as the output file name) will be created in the specified path. Then ReportUnit will create a single HTML file (**TestResult.html**) in the same folder. This will be the first report and will give us unit test results.

Second report will be the coverage report. OpenCover will create report XML (**opencovertests.xml**) using NUnit, then ReportGenerator will create an HTML site with that file in the given path (**C:\UnitTestResults**) and addition to that, the old reports will be saved at (**C:\CoverageHistory**), so each time you run coverage, you can also track coverage changes.

## Notes

HTML publisher plugin uses external resources (js, css) and that is not allowed on jenkins' default configuration. We need to change it as this [wiki page](https://wiki.jenkins-ci.org/display/JENKINS/Configuring+Content+Security+Policy) explains.

In my case jenkins is a windows service and I can change the configuration via **jenkins.xml** and restart the service.

```
<arguments>-Xrs -Xmx256m -Dhudson.model.DirectoryBrowserSupport.CSP= -Dhudson.lifecycle=hudson.lifecycle.WindowsServiceLifecycle -jar "%BASE%\jenkins.war" --httpPort=8080 --webroot="%BASE%\war"</arguments>
```

As suggested, check the setting by running `System.getProperty("hudson.model.DirectoryBrowserSupport.CSP")` command in [Jenkins Script Console](https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+Script+Console)
