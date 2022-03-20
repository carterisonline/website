import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import unocss from 'unocss/vite';
import presetUno from '@unocss/preset-uno';
import { extractorSvelte } from 'unocss';

// https://vitejs.dev/config/
export default defineConfig({
	plugins: [
		svelte(),
		unocss({
			presets: [presetUno()],
			extractors: [extractorSvelte]
		})
	]
});
