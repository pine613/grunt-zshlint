'use strict';

require! {
  child_process: {exec}
  async
}


test-succeeded = (done) ->
  console.log '> grunt zshlint:succeeded'
  exec 'grunt zshlint:succeeded', (err, stdout, stderr) ->
    process.stdout.write(stdout) if stdout
    process.stdout.write(stderr) if stderr

    done(err)


test-failed = (done) ->
  console.log '> grunt zshlint:failed'
  exec 'grunt zshlint:failed', (err, stdout, stderr) ->
    process.stdout.write(stdout) if stdout
    process.stdout.write(stderr) if stderr

    return done('grunt succeeded') if err
    done()


module.exports = (grunt) ->
  grunt.registerTask 'zshlint-test', ->
    done = @async()

    async.parallel [test-succeeded, test-failed]
    , (err) ->
      grunt.log.error(err) if err
      done(err)
