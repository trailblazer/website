## System dependencies

- ruby (~> 3.0)
- rails (~> 7.0.2)
- node (~> 16.14)

## HOW TO GET THIS SHIT GOING

Run `./bin/setup` to install any application dependencies and boot the application using `foreman`,

```
foremane start -f Procfile.dev
```

`foreman` will start both rails and vite server in development mode.

## Structure

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

## Known Issues

1. `Middleware::WesbiteCompiler` will compile website in development for any new changes, but `Torture::Server` doesn't load recently updated `.md.erb` files. You will need to restart `foreman` in order to pick those changes up and generate correct HTML.
