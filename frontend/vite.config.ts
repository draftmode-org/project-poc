import path from 'path'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'

//
// https://github.com/unocss/unocss
//
import Unocss from 'unocss/vite'
import {
    presetAttributify,
    presetIcons,
    presetUno,
    transformerDirectives,
    transformerVariantGroup,
} from 'unocss'

//
// https://vitejs.dev/config/
//
export default ({ mode }) => {
    return defineConfig({
        resolve: {
            alias: {
                // alias to resolve using of ~/ to start inside /src folder
                '~/': `${path.resolve(__dirname, 'src')}/`
            },
        },
        css: {
            preprocessorOptions: {
                scss: {
                    additionalData: `@use "~/styles/element/index.scss" as *;`,
                },
            },
        },
        server: {
            // watch for every host calling vite
            host: "0.0.0.0",
            // activate hotreloading
            watch: {
                usePolling: true
            }
        },
        plugins: [
            vue(),
            Components({
                // allow auto load markdown components under `./src/components/`
                extensions: ['vue', 'md'],
                // allow auto import and register components used in markdown
                include: [/\.vue$/, /\.vue\?vue/, /\.md$/],
                resolvers: [
                    ElementPlusResolver({
                        importStyle: 'sass',
                    }),
                ],
                dts: 'src/components.d.ts',
            }),
            Unocss({
                presets: [
                    presetUno(),
                    presetAttributify(),
                    presetIcons({
                        scale: 1.2,
                        warn: true,
                    }),
                ],
                transformers: [
                    transformerDirectives(),
                    transformerVariantGroup(),
                ]
            }),
        ],
    })
}
