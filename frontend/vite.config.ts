
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { VitePWA } from 'vite-plugin-pwa'

export default defineConfig({
  base: '/pos/',

  plugins: [
    react(),

    VitePWA({
      registerType: 'autoUpdate',

      manifest: {
        name: 'Nàng Hoa POS',
        short_name: 'Nàng Hoa',
        id: '/pos/',
        start_url: '/pos/',
        scope: '/pos/',
        display: 'standalone',
        theme_color: '#6B4636',
        background_color: '#F8F1E8',

        icons: [
          {
            src: 'pwa-192x192.png',
            sizes: '192x192',
            type: 'image/png'
          },
          {
            src: 'pwa-512x512.png',
            sizes: '512x512',
            type: 'image/png'
          }
        ]
      }
    })
  ]
})
    