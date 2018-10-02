defmodule TBC.Commands.Ban do
  alias Coxir.Struct.Member
  import Elosuite.Helpers

  def exec(member, by, guild, reason) do
    member = Member.get(guild, member)
    by = Member.get(guild, by)

    memberRoles = getHighestRole(member[:roles])
    byRoles = getHighestRole(by[:roles])
    if memberRoles < byRoles do
      Member.ban(member, reason: reason)
    else
      :forbidden
    end
  end
end
