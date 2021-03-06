defmodule Cards do
  # Um módulo é uma coleção de metodos/funções
  # É possivel ter varios metodos com o mesmo nome, apenas com o numero de
  # parametros diferentes.

  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # PRIMEIRA MANEIRA DE CRIAR A LISTA DE VALORES E TIPOS
    #  cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end
    # List.flatten(cards)

    # SEGUNDS MANEIRA DE CRIAR A LISTA DE VALORES E TIPOS
    # Passa pelas duas listas na mesma comprehension (for)
    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  @doc """
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  # Metodos com "?" nao mudam em funcionalidade, é apenas uma boa pratica
  # para facilitar o entendimento dos desenvolvedores.
  @doc """
    Determines wether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck,1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  """
  def load(filename) do
    # {status, binary} = File.read(filename)
    # case status do
    #   :ok -> :erlang.binary_to_term(binary)
    #   :error -> "That file does not exist"
    # end

    # Nesse maneira menor, estamos fazendo uma comparação do resultado do case,
    # e tambem estamos fazendo uma associação. Veja que File.read retorna
    # um tuple {status_da_operação, binary_encontrado/razão_do_erro},
    # aonde validamos se o status é igual a :ok (atom, igual uma string, valor fixo),
    # já associando o binary_encontrado á variavel binary na mesma linha e usando-a
    # e fazemos a mesma coisa com o erro, que foi colocado um "_"  na razão
    # para indicar que não será utilizada
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
  """
  def create_hand(hand_size) do
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    {hand, _rest} =
      Cards.create_deck()
      |> Cards.shuffle()
      # Pipe operator funciona apenas com o primeiro parametro(s) em ordem
      |> Cards.deal(hand_size)

    hand
  end
end
