# React.js

# Main aspects

Virtual DOM, Flux, JSX, immutable view, components... There are lots of new concepts with React.js when you first start to research.

Because Facebook owns React *(they are using React internally and they decided to open the source of it)*, they created React to solve their problems. But those problems are our problems too. 

The main motivation is solving their maintenance problems. Modern web development needs rise up and complexity to build these structures increased exponentially. 

Everyday a new javascript framework introduced to the market, but learning, using, and maintaining them is hard. I'm a mainly backend developer and these new frontend programming problems are exhausting for me. Web is not designed for dynamic web sites and this brings an inevitable complexity to the table, though not many of the new javascript technologies try to solve these problems.

React is different in many areas and this radical ideas really change something. Lets review these ideas:

* DOM reading and manipulation is unneccesary and slow.
	* instead use Virtual DOM (a representation of DOM on javascript) and compute DOM changes with an efficient diff algorithm
	* Renders from scratch when change happens on data (state) by events
* Trying to keep up with templates, CSS and javascript is hard
	* Uses seperation of concerns (seperate view and data logic elegantly with components) instead of seperation of technologies (by putting templates, javascript, stylesheets to seperate files)
	* Uses plain old javascript objects and inline styling (no it's not an anti-pattern) instead of CSS frameworks
* Composable component system (reusibility at its best)
* Built for unidirectional data flow

## Rendering

* Render can be both on server and client
	* Thus enables server to render HTML with data ready
	* Quick first renders
	* Easy to use for example for email templating from server
* Render from scratch on every change
	* Easy to develop, no need to sync mutations manually

### Virtual DOM

* Lightweight representation of actual DOM (which is very heavy API and its performance is awful)

	> The data returned from **render** is neither a string nor a DOM node -- it's a lightweight description of what the DOM should look like.

* Makes easy for react to calculate diffs and changes on DOM causing smallest DOM mutaion
* Makes batch updates possible and mitigate unnecessary re-renders
* Abstract representation of view, could be used to render other than HTML, like React Native	 (iOS and Android), SVG, HTML5 Canvas etc.
* SyntheticEvents:

	> React normalizes events so that they have consistent properties across different browsers. (see: [Events](https://facebook.github.io/react/docs/events.html))

### JSX

XML-like language for your react components. JSX code needs to be transpiled to javascript by a transpiler. It is easier to create react components rather than creating them with raw javascript. We'll see them by the example.

## Data - Props and state

* States are mutable
* A state can only be modified in its own component
* A state can initially be set through in getInitialState or in setState functions
* props are immutable
	* so you just need to find its caller to find out who changed the data
	* again this is easier with react chrome dev extension
	* props have types!
		* early validation of data to find out errors' roots
* Use props from components' ancestor or from `getInitialProps` for which data won't change, and use state for its own information that will change in time.

## Easy to fix

Often problems in software arise from changes in states, and finding the source of a change is not an easy task. You need to find some id or a unique selector from the DOM to search your code base and data variable bound to it. 

Then you needed to find places where that variable is changed.

Generally you find the HTML node, find the template, find the javascript which renders that template -often it is a javascript file containing all of the code of that page-, find related code on that page, sometimes also find the related css section from your styles document. 

With react you can use chrome react extension to see which react component you need to look. Because it is a component, you can see all related javascript and styles in one place. 

But that's not the only problem. Even if you think you find the source of the bug, it doesn't mean it is the right place.

This part of fixing is the most challenging one mostly on large code bases which the data could be changed from anywhere by anyone.

Again react solves this by limiting changes to states and in that component only. Also props doesn't changed at all thanks to its immutable structure. Need to find ancestor components though.

After detecting the component and the state variable, you just only control getInitialState or calls of setStates of that variable.

## Server side rendering

One of the important features of React is the ability to serving react on the first request from server. Many client side applications receive a tiny html but big chunks of javascript to run. Then on client side, html is created and rendered by javascript. Data needs to be downloaded by ajax methods and all of them take some time when initial loading the page.

By the other hand, server side rendering allows the client to receive HTML with data bound ready from the server. This also helps your application's ability to be read and indexed by the search engines (SEO friendly pages).

Once this HTML is displayed by the user’s browser, React will make the same computations on the client side again, though the data is the same, no change to the DOM will be made. After that react will attach javascript event handlers.

> There is a little possibility of user could not interact with the site until react attaches the event handlers. But that would be quick enough that the user won't recognize it.

**Sources:**

* <https://medium.com/@mjackson/universal-javascript-4761051b7ae9#.x8rk8mg5w>
* <https://www.terlici.com/2015/03/18/fast-react-loading-server-rendering.html>
* <https://www.npmjs.com/package/react-server-example>

# Flux

It isn't a framework or anythink but it is a concept. A concept that answers: "How to change data and sync your visuals?"

Other alternatives could be MVC, MVVM, MVP architectures, but the main difference is in Flux is view seems to do the updates itself automatically because view renders from scratch in every change.

Of course this would be very slow because of the rendering the whole thing again and again, but we have Virtual DOM and it solves many of the problems of this approach. In fact Facebook says, while they were updating their views to React and Flux, they see in many cases it is faster than before if it is not the same.

This is because of the dirty mechanism and the diff algorithm and I'm not going to go into that deeply. If you want more information, you can check the links:

**Sources:**

* <http://calendar.perfplanet.com/2013/diff/>
* <https://facebook.github.io/react/docs/reconciliation.html>
* <http://blog.andrewray.me/flux-for-stupid-people/>

# React Lifecycle

You can control on 

* **componentWillMount:** You can change the state before rendering.
* **componentDidMount:** (client) You can react the DOM after this phase.
* **componentWillReceiveProps(nextProps):** 	When a new render happens, you can check the new props with the old `this.props` and change a state.
* **shouldComponentUpdate(nextProps, nextState):** When a new render happens, you can cancel that component and its children components rendering with a `return false` statement. Use this for tweaking and optimizing when necessary. It is not used when called `forceUpdate`

	> For futher reading I recommend these articles: Using [Pure render mixin](https://facebook.github.io/react/docs/pure-render-mixin.html) for simple your props and states for shallow compares or with [Immutable Objects](https://facebook.github.io/immutable-js) by just checking references to objects if they changed or not.

* **getInitialState:** Just return to set the initial/default component state
* **getDefaultProps:** Same as above
* **componentWillUnmount:** Will be called if component is disposed or removed. This is the place where you want to unbind your events
* **render:** You return your react component here. There must be only one root element. Can be used JSX. On server side you can use **renderToString**.

**Sources:**

* <https://facebook.github.io/react/docs/component-specs.html#lifecycle-methods>

# Development

We're going to use **webpack** instead of **browserify** and **grunt**. Webpack can do both of their capabilities, and in addition it can optimize your resources with smart bundling.

Our main goal is use common code for server and client side, so packaging server side js to client side js (bundling) efficiently is crucial.

I'll explain more by listing webpack's features because there are tons of them:

* It creates a dependency graph in your codebase, and you can create different bundles for your modules (entry points). Use CommonJS, AMD or ES6 modules for dependencies. (This ability itself is superb for client side javascript!)
* Code Splitting: It can optimize your resources, like uglifying. Uglify removes not used code parts from your bundle. This allows us using some conditional checks whether or not it is client side. So we can remove code that only works server side from our client side bundle. Yay!

	> Checkout uglifyjs documentation for more: <https://github.com/mishoo/UglifyJS2#conditional-compilation>
	
	Another trick to combimne with uglify is the define plugin as told by the Pete Hunt's howto:
	
	> We have code we want to gate only to our dev environments (like logging) and our internal dogfooding servers (like unreleased features we're testing with employees). In your code, refer to magic globals: <https://github.com/petehunt/webpack-howto#6-feature-flags>

* There are lots of *loaders* for webpack. Loaders turns everything into JS! Like TypeScript, CoffeeScript, your CSS files (and less, sass too) or even your images will be on the output of the bundled JS file (if it's not too big).
* Has a development server (Yay!) which listens changes on your bundle files and sends to client for reloading. 
* Pluggable architecture. List of default plugins: <https://github.com/webpack/docs/wiki/list-of-plugins>
* [Multiple entry chunks](https://webpack.github.io/docs/code-splitting.html#multiple-entry-chunks) for example to create different chunks for your different pages
* [Commons chunk plugin](https://github.com/webpack/docs/wiki/list-of-plugins#commonschunkplugin) may be used with [Vendors](https://webpack.github.io/docs/code-splitting.html#split-app-and-vendor-code)
* Using Externals for example to use React.js from an CDN or smt. instead of your node.js package

**Sources:**

* <https://webpack.github.io/docs/configuration.html>
* <https://github.com/petehunt/webpack-howto>
* <https://www.youtube.com/watch?v=VkTCL6Nqm6Y>

# Sources

* <https://facebook.github.io/react/blog/2013/06/05/why-react.html>
* <https://speakerdeck.com/vjeux/why-does-react-scale-jsconf-2014>
* <https://speakerdeck.com/vjeux/react-presentation>
* <http://blog.andrewray.me/reactjs-for-stupid-people/> (Estafurullah)