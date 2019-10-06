import { Elm } from '../elm/Main.elm'
import { promisify } from 'elm-promisify'

const node = document.querySelector('[data-elm]')
const flags = {

}

promisify(Elm.Main, { node, flags })
  .then(app => {
    window.darkMode = () => app.ports.updateTheme.send('dark')
    window.lightMode = () => app.ports.updateTheme.send('light')
  })
