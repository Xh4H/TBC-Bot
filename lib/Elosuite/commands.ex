defmodule TBC.Commands do
  use Coxir.Commander
  import TBC.Helpers
  alias TBC.Commands.{Kick, Ban, Info, Eval}
  @prefix "<"

  # KICK COMMAND
  @permit :KICK_MEMBERS
  command kick(who, reason) do
    cond do
      String.starts_with?(who, "<@") ->
        who
        |> String.replace(~r/[^\d]/, "")
        |> Kick.exec(message.author.id, message.guild.id, reason)
        |> case do
          :ok ->
            Message.reply(message, embed: buildSuccessEmbed("#{who} has been successfully kicked."))
          :forbidden ->
            Message.reply(message, embed: buildForbiddenEmbed("You are trying to kick a higher member in the roles hierarchy than you."))
          err ->
            Message.reply(message, embed: buildErrorEmbed("An error has occured.\nContact the developer."))
            IO.inspect(err)
        end
      true ->
        Message.reply(message, embed: buildErrorEmbed("Please mention the member you want to kick."))
    end
  end

  # BAN COMMAND
  @permit :BAN_MEMBERS
  command ban(who, reason) do
    cond do
      String.starts_with?(who, "<@") ->
        who
        |> String.replace(~r/[^\d]/, "")
        |> Ban.exec(message.author.id, message.guild.id, reason)
        |> case do
          :ok ->
            Message.reply(message, embed: buildSuccessEmbed("#{who} has been successfully banned."))
          :forbidden ->
            Message.reply(message, embed: buildForbiddenEmbed("You are trying to ban a higher member in the roles hierarchy than you."))
          err ->
            Message.reply(message, embed: buildErrorEmbed("An error has occured.\nContact the developer."))
            IO.inspect(err)
        end
      true ->
        Message.reply(message, embed: buildErrorEmbed("Please mention the member you want to ban."))
    end
  end

  # INFO COMMAND
  @permit &admin?/2
  command info do
    Message.reply(message, %{embed: Info.exec()})
  end

  # EVAL COMMAND
  @permit &admin?/2
  command eval(string) do
    Eval.exec(message, channel, string)
  end

  # VOICE JOIN COMMAND
  @space :voice
  @permit &admin?/2
  command join do
    member.voice
    |> Voice.join
  end

  # VOICE LEAVE COMMAND
  @space :voice
  @permit &admin?/2
  command leave do
    member.voice
    |> Voice.leave
  end

  # VOICE PLAY COMMAND
  @space :voice
  @permit &admin?/2
  command play(term) do
    message
    |> join

    member.voice
    |> Voice.play(term)
  end

  # VOICE STOP COMMAND
  @space :voice
  @permit &admin?/2
  command stop do
    member.voice
    |> Voice.stop_playing
  end

  # COOKIE EAT COMMAND
  @space :cookie
  command eat do
    mention = "<@#{author.id}>"
    content = "here, have a :cookie: #{mention}"
    Message.reply(message, content)
  end

end
