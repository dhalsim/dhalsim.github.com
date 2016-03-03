# Testify

* Function Exchange
	* Clone someone elses function
	* Should create a package with other required functions, but with a generated interface of that particular function exposed.
* Test Exchange
	* Merge someone elses tests with yours
* Test Matching
	* Parametreler eşleştirilmesi
	* Testlerin karşılıklı çalıştırılarak sonuçların eşleştirilmesi
	* interoperability through language to language transformaters
		* if it is typescript you can do like [this](https://github.com/praeclarum/Netjs) or resharper?
	* Should people write tests on typescript? or .d.ts files? or not mandatory?
* Manuel eşleştirme
	* Adapters
		* From service to client (service adapter)
		* From client to service (client adapter) 
* Testify Register
* Testify search and matching
* Testify package usage
	* From cloud
	* From any network service
	* From your own computer
* Computation of structures
	* Tree structure of functions calling other functions
	* Tree structure of functions calling other functions over network
	* Traversing tree (neo4j?)
	* Parallelisation
		* Given a hash of function structure and hash of function content, we can distinguish same functions, so we can decompose a function set and run through many nodes
	* Performance tuning
		* Given a hash of function structure and hash of function content and its test, we can find more performant functions from other nodes, or can be found through composition
	* We should provide the computation persistent, so it can be downloadable from source control, or can continue from previous state
	* persistent computation makes sharing and merging through network possible
* Collobrative development
	* If the development can be realtime over a network system (like Google Docs), participants can write tests together, and system can provide matched functions automatically, so development time can be accelerated.
* Package modifications
* Testify enterprise
	* Provide a private test folder, other than that it will be shared by all
	* Provide a service folder, that can be called from testify enterprice accounts' computer
	* Provide seperate tools specific for languages, for example write a VS extension for c#, or eclipse/intellij plugin for java.

## How to use a shared service

### Add Service:

**Add:**

~~~js
function add(number1, number2) {
	return number1 + number2;
}

module.exports = add;
~~~

<br />
**Schema:**

~~~js
var addSchema = new graphql.GraphQLSchema({
  query: new graphql.GraphQLObjectType({
    name: "AddDefinition",
    fields: {
      result: {
        type: graphql.GraphQLFloat,
        args: {
          num1: { type: graphql.GraphQLFloat },
          num2: { type: graphql.GraphQLFloat }
        },
        resolve: function (args) {
          return require("./add")(args[0], args[1]);
        }
      }
    }
  })
});

module.exports = addSchema;
~~~

<br />
**Test:**

~~~js
var TestSuite = require("testify").TestSuite;
var addFunc = require("./add");

var suite = TestSuite.testWithSchema(require(	"./schema", function(suite, schema) {
	suite.describe("Adds two numbers, returns the result");
	suite.addTest({
		"when adding a number and another number",
		topic: addFunc,
		"we get their total result": function (topic) {
			var args0 = testify.parameter(schema.args[0], 3);
			var args1 = testify.parameter(schema.args[1], 4);
			var result = testify.parameter(schema.result, 7);
			testify.assertEqual (topic(args0, args1), result);
		}
	});
	suite.addTest({
		"when adding a positive and a negative number",
		topic: addFunc,
		"we get their total result": function (topic) {
			var args0 = testify.parameter(schema.args[0], -3);
			var args1 = testify.parameter(schema.args[1], 4);
			var result = testify.parameter(schema.result, 1);
			testify.assertEqual (topic(args0, args1), result);
		}
	});
});

module.exports = suite;
~~~

<br />
**Register:**

~~~js
testify.register("my-add-func", {
	query: require("./addSchema"),
	test: require("./test"),
	git: { url: "..." }
});
~~~

### Consumer:

**Schema:**

~~~js
var culculateFuncSchema = new graphql.GraphQLSchema({
  query: new graphql.GraphQLObjectType({
    name: "CalculateFuncDefinition",
    fields: {
      result: {
        type: graphql.GraphQLFloat,
        args: {
          num1: { type: graphql.GraphQLFloat },
          num2: { type: graphql.GraphQLFloat }
        }
      }
    }
  })
});

module.exports = culculateFuncSchema;
~~~

<br />
**Test:**

~~~js
var vows = require("vows"),
    testify = require("testify");
    
// test suite
vows.describe("Add two numbers").addBatch({
    "when adding a number and another number": {
        topic: testify.topic,

        "we get their total result": function (topic) {
            testify.assertEqual (topic(3, 4), 7);
        }
    }
});

module.exports = vows;
~~~

<br />
**Testify search:**

~~~
testify-node --test test.js --keywords math add
~~~

Outputs:

* [Exact | **One** | Two ...] match on *my-add-func* [URL]() with **1** test.
* To see matched tests and add additional tests to your suite, type `testify-node --tests my-add-func` and add with `testify-node --tests my-add-func --add NUMBERS_LISTED`
* There are [12 more testify functions]() on your search keywords with **math, add**. To list all of them type `testify-node --list math add`

<br />
**testify.config:**

~~~
var config = {
	uses: {
		add: {
			package: "my-add-func",
			useWith: "cloud|own",
			test: require("./test"),
		}
	}
}

module.exports = config;
~~~

<br />
**useWith option:**

Cloud, uses API from testify cloud, which requires subscription. But it handles management for you.

If you specify own, then you should type `testify-node --install` to update your package.json and automatically run `npm install`

~~~js
var testify = require("testify");
var calculateFunc = testify.require("my-add-func", function(addFunc) {
	return function(num1, num2) {
		return addFunc(num1, num2);	
	});
});

console.log(calculatorFunc(4,5));
~~~

<br />

## A more advanced example (Score board)

What does a score board need to have?

* A list of people, with their scores in it
* A sort function orders descending
* A function to add to scores list
* A function to update a score in the list

Let's write them out as test cases:

<br />
**Test:**

~~~js
var TestSuite = require("testify").TestSuite;

var suite = TestSuite.testWithSchema(require(	"./schema", function(suite, schema) {
	suite.describe("Adds two numbers, returns the result");
	suite.addTest({
		"when adding a number and another number",
		topic: addFunc,
		"we get their total result": function (topic) {
			var args0 = testify.parameter(schema.args[0], 3);
			var args1 = testify.parameter(schema.args[1], 4);
			var result = testify.parameter(schema.result, 7);
			testify.assertEqual (topic(args0, args1), result);
		}
	});
	suite.addTest({
		"when adding a positive and a negative number",
		topic: addFunc,
		"we get their total result": function (topic) {
			var args0 = testify.parameter(schema.args[0], -3);
			var args1 = testify.parameter(schema.args[1], 4);
			var result = testify.parameter(schema.result, 1);
			testify.assertEqual (topic(args0, args1), result);
		}
	});
});

module.exports = suite;
~~~