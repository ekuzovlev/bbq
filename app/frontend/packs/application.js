import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"

import '../scripts/script'
import '../styles/application'

Rails.start()
ActiveStorage.start()

const images = require.context('../images', true)