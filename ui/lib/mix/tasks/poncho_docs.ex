defmodule Mix.Tasks.PonchoDocs do
  use Mix.Task

  @paths [
    "../one/lib/*",
    "../two/lib/*"
  ]

  @impl Mix.Task
  def run(_args) do
    Mix.Shell.IO.info("Generating new poncho docs...")

    # Create a temporary directory
    Mix.Shell.cmd("mkdir lib/temp", fn _x -> nil end)

    # Iterate paths and copy files inside those paths
    Enum.each(@paths, &Mix.Shell.cmd("cp #{&1} ./lib/temp/", fn _x -> nil end))

    # Generate new docs
    Mix.Shell.cmd("mix docs", fn _x -> nil end)

    # Delete copied files
    Mix.Shell.cmd("rm -rf lib/temp", fn _x -> nil end)

    Mix.Shell.IO.info("Finished!")
  end
end
