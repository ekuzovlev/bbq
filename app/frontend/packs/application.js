import * as ActiveStorage from "@rails/activestorage"

import Rails from "@rails/ujs"
import 'bootstrap/dist/js/bootstrap'

import '../scripts/script'
import '../styles/application'

Rails.start()
ActiveStorage.start()

const images = require.context('../images', true)
