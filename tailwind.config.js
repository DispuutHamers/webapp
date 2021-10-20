const colors = require('tailwindcss/colors')

module.exports = {
  // Purge unused TailwindCSS styles
  purge: {
    enabled: ['production'].includes(process.env.NODE_ENV),
    content: [
      './**/*.html.erb',
      './app/helpers/**/*.rb',
      './app/frontend/**/*.js',
    ],
  },
  darkMode: 'class', // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        // Use trueGray as default
        gray: colors.trueGray,
        // Our primary colors are: yellow: #ffed00 red: #e30613
        // Here we extend the palette with our red and yellow colors, generated by https://huey.design/
        'hamers-red': {
          50: '#f8dfdf',
          100: '#f3bebf',
          200: '#ee9d9d',
          300: '#e97879',
          400: '#e64c4d',
          500: '#d80612',
          600: '#ae050f',
          700: '#86040b',
          800: '#600308',
          900: '#3c0205',
        },
        'hamers-yellow': {
          50: '#fffef6',
          100: '#fffded',
          200: '#fffbd3',
          300: '#fff9b8',
          400: '#fff483',
          500: '#ffef4e',
          600: '#e6d746',
          700: '#bfb33b',
          800: '#998f2f',
          900: '#7d7526'
        }
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
