import { Elm } from '../elm/Main.elm'
import { promisify } from 'elm-promisify'

// In case the user has managed to load our app on an ancient rock, we'll check
// to see if localStorage is supported so things don't explode when trying to
// read/write from it.
const hasLocalStorage = 'localStorage' in window

const node = document.querySelector('[data-elm]')
const flags = hasLocalStorage
  ? JSON.parse(window.localStorage.getItem('projects'))
  : []

//
promisify(Elm.Main, { node, flags })
  .then(app => {
    // Elm -> Js ---------------------------------------------------------------
    app.ports.fromElm.subscribe(saveProjects)

    // Js -> Elm ---------------------------------------------------------------
  })

//
function saveProjects (projects = []) {
  console.table(projects)

  if (hasLocalStorage) {
    window.localStorage.setItem('projects', JSON.stringify(projects))
  }
}
