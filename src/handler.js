const actions = {
  formatResponse: function (data) {
    return {
      statusCode: 200,
      body: JSON.stringify(data)
    }
  }
}

exports.getLatestResults = async function () {
  return actions.formatResponse({
    data: 'You called getLatestResults!'
  })
}

exports.getDateResults = async function () {
  return actions.formatResponse({
    data: 'You called getDateResults!'
  })
}

exports.getOrganisationResults = async function () {
  return actions.formatResponse({
    data: 'You called getOrganisationResults!'
  })
}

exports.getTypeResults = async function () {
  return actions.formatResponse({
    data: 'You called getTypeResults!'
  })
}
