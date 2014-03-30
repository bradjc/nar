require! {
  fs
  tar
  zlib
}

module.exports = extract =

  (options, cb) ->
    { archive, dest, gzip } = options
    dest ||= process.cwd!
    stream = fs.create-read-stream archive
    stream.on 'error', -> on-err cb, it

    if gzip
      extract-gzip stream, archive, dest, cb
    else
      extract-normal stream, archive, dest, cb

extract-gzip = (stream, archive, dest, cb) ->
  gzstream = stream.pipe zlib.create-gunzip!
  gzstream.on 'error', -> on-err cb, it
  tstream = gzstream.pipe tar.Extract path: dest
  tstream.on 'error', -> on-err cb, it
  tstream.on 'end', -> cb!

extract-normal = (stream, archive, dest, cb) ->
  tstream = stream.pipe tar.Extract path: dest
  tstream.on 'error', -> on-err cb, it
  tstream.on 'end', -> cb!

on-err = (cb, err) ->
  cb err
  throw err
