defmodule Elosuite.Helpers do
  def admin?(user, _channel) do
    user.id in [
      "191442101135867906"
    ]
  end

  defp hexaToDecimal(str),
    do: Integer.parse(str, 16) |> Tuple.to_list |> List.first

  def buildErrorEmbed(content) do
    %{
      title: "An error occurred",
      description: content,
      color: hexaToDecimal("f73420"),
      footer: %{
        text: "on Elixir #{System.version()}"
      },
    }
  end

  def buildForbiddenEmbed(content) do
    %{
      title: "Forbidden",
      description: content,
      color: hexaToDecimal("d9ea19"),
      footer: %{
        text: "on Elixir #{System.version()}"
      },
    }
  end

  def buildSuccessEmbed(content) do
    %{
      title: "Success",
      description: content,
      color: hexaToDecimal("1ff273"),
      footer: %{
        text: "on Elixir #{System.version()}"
      },
    }
  end

  def getHighestRole(roles) do
    if roles == [] do
      0
    else
      Enum.max_by(roles, fn role -> role[:position] end)[:position]
    end
  end
end
