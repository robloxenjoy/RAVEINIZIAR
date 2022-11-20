/client/verb/discord()
	set name = "discord"
	set desc = "Show Discord Invite."
	set hidden = TRUE
	var/rulesurl = CONFIG_GET(string/rulesurl)
	if(rulesurl)
		if(alert("This will open the discord invite in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		DIRECT_OUTPUT(src, link(rulesurl))
	else
		to_chat(src, span_danger("The discord URL is not set in the server configuration."))
	return

/client/verb/repository()
	set name = "codebase"
	set desc = "Visit Repository."
	set hidden = TRUE
	var/githuburl = CONFIG_GET(string/githuburl)
	if(githuburl)
		if(alert("This will open the repository in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		DIRECT_OUTPUT(src, link(githuburl))
	else
		to_chat(src, span_danger("The repository URL is not set in the server configuration."))
	return
