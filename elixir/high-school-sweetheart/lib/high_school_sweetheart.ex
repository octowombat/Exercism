defmodule HighSchoolSweetheart do
  def first_letter(name) when is_binary(name) do
    name
    |> String.trim()
    |> String.first()
  end

  def initial(name) when is_binary(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> Kernel.<>(".")
  end

  def initials(full_name) when is_binary(full_name) do
    full_name
    |> String.trim()
    |> String.split()
    |> Enum.map_join(" ", &initial/1)
  end

  def pair(full_name1, full_name2) when is_binary(full_name1) and is_binary(full_name2) do
    left = initials(full_name1)
    right = initials(full_name2)

    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{left}  +  #{right}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
