defmodule Mix.Tasks.PonchoDocs do
  use Mix.Task

  @apps [
    "one",
    "two"
  ]

  @impl Mix.Task
  def run(_args) do
    Mix.Shell.IO.info("Generating new poncho docs...")

    # Create a temporary directory
    Mix.Shell.cmd("mkdir lib/temp", fn _x -> nil end)

    # Create app directories
    Enum.each(@apps, &Mix.Shell.cmd("mkdir lib/temp/#{&1}", fn _x -> nil end))

    # Iterate paths and copy files inside those paths
    Enum.each(@apps, &Mix.Shell.cmd("cp ../#{&1}/lib/* ./lib/temp/#{&1}/", fn _x -> nil end))

    # Generate new docs
    Mix.Shell.cmd("mix docs", fn _x -> nil end)

    # Delete copied files
    Mix.Shell.cmd("rm -rf lib/temp", fn _x -> nil end)

    Mix.Shell.IO.info("Finished!")
  end
end
