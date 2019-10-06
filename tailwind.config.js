module.exports = {
  prefix: '',
  important: false,
  separator: ':',

  theme: {
    borderRadius: {
      none: '0',
      sm: '.125rem',
      default: '.25rem',
      lg: '.5rem',
      xl: '1rem',
      full: '9999px'
    },
    gradients: theme => ({
      'gradient-gray': ['30deg', theme('colors.gray.300'), theme('colors.gray.400')],
      'gradient-gray-dark': ['30deg', theme('colors.gray.400'), theme('colors.gray.600')],
      'gradient-red': ['30deg', theme('colors.red.300'), theme('colors.red.400')],
      'gradient-red-dark': ['30deg', theme('colors.red.400'), theme('colors.red.600')],
      'gradient-orange': ['30deg', theme('colors.orange.300'), theme('colors.orange.400')],
      'gradient-orange-dark': ['30deg', theme('colors.orange.400'), theme('colors.orange.600')],
      'gradient-yellow': ['30deg', theme('colors.yellow.300'), theme('colors.yellow.400')],
      'gradient-yellow-dark': ['30deg', theme('colors.yellow.400'), theme('colors.yellow.600')],
      'gradient-green': ['30deg', theme('colors.green.300'), theme('colors.green.400')],
      'gradient-green-dark': ['30deg', theme('colors.green.400'), theme('colors.green.600')],
      'gradient-teal': ['30deg', theme('colors.teal.300'), theme('colors.teal.400')],
      'gradient-teal-dark': ['30deg', theme('colors.teal.400'), theme('colors.teal.600')],
      'gradient-blue': ['30deg', theme('colors.blue.300'), theme('colors.blue.400')],
      'gradient-blue-dark': ['30deg', theme('colors.blue.400'), theme('colors.blue.600')],
      'gradient-indigo': ['30deg', theme('colors.indigo.300'), theme('colors.indigo.400')],
      'gradient-indigo-dark': ['30deg', theme('colors.indigo.400'), theme('colors.indigo.600')],
      'gradient-purple': ['30deg', theme('colors.purple.300'), theme('colors.purple.400')],
      'gradient-purple-dark': ['30deg', theme('colors.purple.400'), theme('colors.purple.600')],
      'gradient-pink': ['30deg', theme('colors.pink.300'), theme('colors.pink.400')],
      'gradient-pink-dark': ['30deg', theme('colors.pink.400'), theme('colors.pink.600')]
    })
  },
  variants: {
    gradients: ['responsive', 'hover']
  },
  corePlugins: {},
  plugins: [
    require('tailwindcss-plugins/gradients')
  ]
}
