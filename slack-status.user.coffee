setUsername = (name, status) ->
    req = new XMLHttpRequest
    req.open "POST", "/api/users.profile.set"
    req.setRequestHeader "Content-Type", "application/x-www-form-urlencoded; charset=UTF-8"

    req.send "users=" + boot_data.user_id + "&" +
        "profile=" + (JSON.stringify {
            first_name: name
            last_name: "(" + status + ")"
        }) + "&" +
        "token=" + boot_data.api_token

retry = 30

setup = ->
    try
        channels = document.getElementById "channels_scroller"
        name = (TS.members.getMemberById boot_data.user_id).real_name
        unless channels? and name?
            throw null
    catch e
        if retry-- > 0
            window.setTimeout setup, 100
        return
    status = name.match "\\(([^)]*)\\)$"
    if status? and status.length > 1
        status = status[1]
        name = (name.substring 0, (name.indexOf status) - 1).trim()
    else
        status = ""

    statusBox = document.createElement "input"
    statusBox.setAttribute "placeholder", "Status"
    statusBox.value = status
    statusBox.id = "statusBox"
    statusBox.addEventListener "keyup", (e) ->
        if e.keyCode is 13
            status = statusBox.value
            setUsername name, status
    channels.appendChild statusBox

window.setTimeout setup, 100
