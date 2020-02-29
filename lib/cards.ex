defmodule Cards do
  # Um módulo é uma coleção de metodos/funções
  # É possivel ter varios metodos com o mesmo nome, apenas com o numero de 
  # parametros diferentes.

  def create_deck do
    ["Ace", "Two", "Three"]
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

end
