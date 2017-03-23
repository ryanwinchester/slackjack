defmodule Slacklog.Slack.RTM do
  @moduledoc """
  Get the events we want from slack.
  
  ### Examples
  
      iex> Slack.Bot.start_link(Slacklog.Slack.RTM, [], Application.get_env(:slacklog, :key))
      {:ok, #PID<0.246.0>}
  
  """

  use Slack

  @doc """
  Start the bot connection to slack.
  """
  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

   @doc """
  A channel was archived.
  see: https://api.slack.com/events/channel_archive
  """
  def handle_event(event = %{type: "channel_archive"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was created.
  see: https://api.slack.com/events/channel_created
  """
  def handle_event(event = %{type: "channel_created"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was deleted.
  see: https://api.slack.com/events/channel_deleted
  """
  def handle_event(event = %{type: "channel_deleted"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was renamed.
  see: https://api.slack.com/events/channel_rename
  """
  def handle_event(event = %{type: "channel_rename"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A channel was unarchived.
  see: https://api.slack.com/events/channel_unarchive
  """
  def handle_event(event = %{type: "channel_unarchive"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A message was sent to a channel.
  see: https://api.slack.com/events/message
  """
  def handle_event(event = %{type: "message"}, _slack, state) do
    _channel = event.channel
    {:ok, state}
  end
  
  @doc """
  A pin was added to a channel.
  see: https://api.slack.com/events/pin_added
  """
  def handle_event(event = %{type: "pin_added"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A pin was removed from a channel.
  see: https://api.slack.com/events/pin_removed
  """
  def handle_event(event = %{type: "pin_removed"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  A team member's data has changed.
  see: https://api.slack.com/events/user_change
  """
  def handle_event(event = %{type: "user_change"}, _slack, state) do
    IO.inspect event
    {:ok, state}
  end

  @doc """
  Do nothing for events we don't care about.
  """
  def handle_event(_event, _slack, state), do: {:ok, state}

  @doc """
  Send a message or something.
  """
  def handle_info({:message, text, channel}, slack, state) do
    IO.puts "Sending your message, captain!"
    send_message(text, channel, slack)
    {:ok, state}
  end
  def handle_info(_, _, state), do: {:ok, state}

end
