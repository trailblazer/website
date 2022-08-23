[![Netlify Status](https://api.netlify.com/api/v1/badges/1216fc0b-4635-40d4-8168-aa76e7a1fabd/deploy-status)](https://app.netlify.com/sites/ornate-heliotrope-1c15e2/deploys)

## System dependencies

- ruby (~> 3.0)
- rails (~> 7.0.2)
- node (~> 16.14)

## Setup

Run `./bin/setup` to install any application dependencies and boot the application using `foreman`,

```
foreman start -f Procfile.dev
```

`foreman` will start both rails and vite server in development mode.

## How does this work ?

- This is a fairly simple Rails app with sprinkles of cells and trailblazer.
- All documentation MD files and it's compilation logic is stored under `app/concepts`.
- All MD files are compiled and generated HTML is stored in `public` to be served as statically.
- In local development, if you change any MD file and reload the page in browser, `Middleware::WebsiteCompiler` will detect the change and compile website again.
- Newly made changes are persisted in `public` directory again and will be served back in same the request :tada:
- Any asset changes are reloaded using [vite](https://vitejs.dev/) in HMR mode :fire:

## Directory Structure

```
1. app/concepts (Contains all the operations and MD files to generate documentation HTML)
  1.1 app/concepts/application (Application wide operations and cells)
  1.2 app/concepts/home (Home page operations and cells)
  1.3 app/concepts/documentation (Documentation (Trailblazer, cells, reform etc) operations, cells and MD files)
  1.4 app/concepts/page (Page (About Us, Learn etc) operations, cells and MD files)
2. app/frontend (Contains all the JS, CSS and image files)
3. public (Contains the documentation HTML generated in development mode)
4. public/dist (Contains the documentation HTML generated in production mode (using `rails publish` task))
5. lib/tasks/publish.rake (Contains the rake task to create and push publish commit)
6. lib/middleware/website_compiler.rb (Contains the middleware to check and compile the documentation MD files)
7. config/routes.rb (Contains redirect rules for development env)
```

## Deployment

Run `rails publish` to publish any current changes. This will

  1. Generate HTML files in `public/dist`
  2. Pack Vite assets into `public/dist`
  3. Commit `public/dist` into the repository
  4. Push changes to the current branch

If changes are pushed on main branch, [render.com](render.com) will automatically deploy and update the website.

## Code Snippets

Per default, code snippets using the `<%= code ... %>` helper tag are extracted from the respective repository when compiling the site. This repository must be sitting in the same directory that `website`'s in. You need to clone all needed repositories.

```
website/
trailblazer-activity/
trailblazer-activity-dsl-linear/
trailblazer-operation/
trailblazer-cells/
reform/
etc.
```
