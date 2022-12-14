// Copied from https://gorails.com/episodes/purgecss
let environment = {
  plugins: [
    require("autoprefixer"),
    require("postcss-import"),
    require("postcss-flexbugs-fixes"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009",
      },
      stage: 3,
    }),
  ],
};

// Only run PurgeCSS in production environment
if (process.env.RAILS_ENV === "production") {
  environment.plugins.push(
    require("@fullhuman/postcss-purgecss")({
      content: [
        "./app/concepts/**/*",
        "./app/frontend/**/*",
        "./config/initializers/torture_server.rb",
      ],
    })
  );
}

module.exports = environment;
