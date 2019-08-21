const actions = {
  formatResponse (data) {
    return {
      statusCode: 200,
      body: JSON.stringify(data)
    }
  }
}

exports.getLatestResults = async () => actions.formatResponse({
  data: 'You called getLatestResults!'
})

exports.getDateResults = async () => actions.formatResponse({
  data: 'You called getDateResults!'
})

exports.getOrganisationResults = async () => actions.formatResponse({
  data: 'You called getOrganisationResults!'
})

exports.getTypeResults = async () => actions.formatResponse({
  data: 'You called getTypeResults!'
})
