import { defineConfig } from "vite";
import RubyPlugin from "vite-plugin-ruby";

export default defineConfig({
  plugins: [RubyPlugin()],
  build: {
    sourcemap: true,
  },
  css: {
    devSourcemap: true,
  },
});
