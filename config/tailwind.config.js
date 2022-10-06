const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      minHeight: {
        '60px': '60px',
        '45px': '45px',
        '30px': '30px',
        '100px': '100px',
        '200px': '200px',
      },
      minWidth: {
        '60px': '60px',
        '45px': '45px',
        '30px': '30px',
      },
      fontSize: {
        '36px': '36px',
      },
      padding: {
        '20pc': '20%',
        '8p3pc': '8.3%',
        '100pc': '100%',


      },
    },
  },
  plugins: [
    // require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
  ]
}
