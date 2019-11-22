const mocha = require('mocha')
const assert = require('assert')

mocha.describe('tests', () => {
  return mocha.it('should run a test', () => {
    return assert.equal('1', 1)    
  })
})