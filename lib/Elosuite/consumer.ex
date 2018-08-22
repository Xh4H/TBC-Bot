defmodule Elosuite.Consumer do
  use Coxir.Commander
  use Elosuite.Commands

  def handle_event({:READY, _user}, state) do
    game = %{
      type: 0,
      name: "with the time"
    }
    Gateway.set_status("dnd", game)

    {:ok, state}
  end
end
