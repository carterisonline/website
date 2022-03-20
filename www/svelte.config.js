import preprocess from 'svelte-preprocess';
import adapter from '@sveltejs/adapter-node';
import { extractorSvelte } from 'unocss';
import unocss from 'unocss/vite';
import presetUno from '@unocss/preset-uno';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	kit: {
		adapter: adapter({ out: 'build' }),
		vite: () => ({
			plugins: [
				unocss({
					presets: [presetUno()],
					extractors: [extractorSvelte]
				})
			]
		})
	},
	preprocess: preprocess()
};

export default config;
