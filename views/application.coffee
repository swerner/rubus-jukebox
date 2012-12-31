$ ->
  $(".track").click( ->
    $.get("/play/#{$(this).data("id")}", ->
      console.log("sent")
    )
  )

  $("#stop_button").click( ->
    $.get('/stop_music')
  )

  # setTimeout(reloadQueue, 1000)
  # setTimeout(checkNowPlaying, 1000)

# checkNowPlaying = ->
  # $.getJSON("/now_playing.json", (data)->
    # $("#now-playing").html(data)
  # )
  # setTimeout(checkNowPlaying, 1000)

# reloadQueue = ->
  # $.getJSON("/queue.json", (data) ->
    # $("ol.queue").html("")
    # for track in data 
      # $("ol.queue").append("<li>#{track}</li>")
  # )

  # setTimeout(reloadQueue, 1000)
