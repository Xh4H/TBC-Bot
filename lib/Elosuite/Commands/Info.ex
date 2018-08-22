defmodule Elosuite.Commands.Info do
  alias Coxir.Struct.{User, Guild, Member, Channel, Message}
  import Elosuite.Helpers

  def exec() do
    project = Coxir.Mixfile.project()
    version = project[:version]
    name = project[:name]

    count = fn struct ->
      struct
      |> apply(:select, [])
      |> length
    end

    voice = Voice
    |> Supervisor.count_children
    |> Map.get(:active)

    %{
      title: "Information",
      color: 0x900C3F,
      footer: %{
        text: "#{name}-#{version} on Elixir #{System.version()}"
      },
      fields: [
        %{
          name: "Users",
          value: count.(User),
          inline: true
        },
        %{
          name: "Guilds",
          value: count.(Guild),
          inline: true
        },
        %{
          name: "Members",
          value: count.(Member),
          inline: true
        },
        %{
          name: "Channels",
          value: count.(Channel),
          inline: true
        },
        %{
          name: "Messages",
          value: count.(Message),
          inline: true
        },
        %{
          name: "Voice",
          value: voice,
          inline: true
        }
      ]
    }
  end
end
