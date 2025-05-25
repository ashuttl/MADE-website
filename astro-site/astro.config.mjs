import { defineConfig } from 'astro/config';

export default defineConfig({
  markdown: {
    shikiConfig: {
      // Choose a theme you like. Some popular options:
      // 'github-dark', 'github-light', 'nord', 'rose-pine', 'dracula', 'material-theme-palenight'
      theme: 'github-light', // Defaulting to a light theme
      wrap: true, // Optional: adds word wrap to code blocks
    },
  },
  // If site URL is known, add it here, e.g.
  // site: 'https://example.com',
});
