import { Elm } from '../elm/Main.elm'
import { promisify } from 'elm-promisify'

const node = document.querySelector('[data-elm]')
const flags = {

}

promisify(Elm.Main, { node, flags })
  .then(app => {

  })
