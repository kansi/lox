defmodule LoxTest.LoxLexer do
  use ExUnit.Case

  describe "[token: single character token]" do
    test "extracts single character tokens" do
      assert {:ok, [{:left_paran, 1}], 1} == :lox_lexer.string('(')
      assert {:ok, [{:right_paran, 1}], 1} == :lox_lexer.string(')')
      assert {:ok, [{:left_brace, 1}], 1} == :lox_lexer.string('{')
      assert {:ok, [{:right_brace, 1}], 1} == :lox_lexer.string('}')
      assert {:ok, [{:comma, 1}], 1} == :lox_lexer.string(',')
      assert {:ok, [{:dot, 1}], 1} == :lox_lexer.string('.')
      assert {:ok, [{:minus, 1}], 1} == :lox_lexer.string('-')
      assert {:ok, [{:plus, 1}], 1} == :lox_lexer.string('+')
      assert {:ok, [{:semicolon, 1}], 1} == :lox_lexer.string(';')
      assert {:ok, [{:slash, 1}], 1} == :lox_lexer.string('/')
      assert {:ok, [{:star, 1}], 1} == :lox_lexer.string('*')
    end
  end

  describe "[token: FLOAT] :lox_lexer" do
    test "returns float" do
      assert {:ok, [{:float, 1, 10.9}], 1} == :lox_lexer.string('10.90')
    end

    test "returns float with correct digits after decimal" do
      assert {:ok, [{:float, 1, 9999.999999}], 1} == :lox_lexer.string('9999.999999')
    end

    test "returns float when sign is provided" do
      assert {:ok, [{:float, 1, 10.9}], 1} == :lox_lexer.string('+10.90')
      assert {:ok, [{:float, 1, -10.9}], 1} == :lox_lexer.string('-10.90')
    end

    test "returns error when float is provided in invalid format " do
      assert {:error, {1, :lox_lexer, {:user, {:invalid_float, '.90'}}}, 1} =
               :lox_lexer.string('.90')

      assert {:error, {1, :lox_lexer, {:user, {:invalid_float, '90.'}}}, 1} =
               :lox_lexer.string('90.')
    end
  end

  describe "[token: INTEGER] :lox_lexer" do
    test "return integer" do
      assert {:ok, [{:integer, 1, 10}], 1} == :lox_lexer.string('10')
      assert {:ok, [{:integer, 1, -10}], 1} == :lox_lexer.string('-10')
    end
  end

  describe "[token: WHITESPACE] :lox_lexer" do
    test "skips white space" do
      assert {:ok, [], 2} == :lox_lexer.string('\r\t\s\n')
    end
  end

  describe "[token: IDENTIFIER] :lox_lexer" do
    test "return valid token" do
      assert {:ok, [{:identifier, 1, "valid_token"}], 1} == :lox_lexer.string('valid_token')
    end
  end

  describe "[token: COMPARATOR] :lox_lexer" do
    test "return valid comparators" do
      assert {:ok, [{:comparator_lt, 1}], 1} == :lox_lexer.string('<')
      assert {:ok, [{:comparator_gt, 1}], 1} == :lox_lexer.string('>')
      assert {:ok, [{:bang, 1}], 1} == :lox_lexer.string('!')
      assert {:ok, [{:equal, 1}], 1} == :lox_lexer.string('=')
      assert {:ok, [{:comparator_leq, 1}], 1} == :lox_lexer.string('<=')
      assert {:ok, [{:comparator_geq, 1}], 1} == :lox_lexer.string('>=')
    end
  end

  describe "[token: RESERVED WORDS]" do
    test "scans reserved words" do
      assert {:ok, [{:boolean_and, 1}], 1} == :lox_lexer.string('and')
      assert {:ok, [{:boolean_or, 1}], 1} == :lox_lexer.string('or')
      assert {:ok, [{nil, 1}], 1} == :lox_lexer.string('nil')
      assert {:ok, [{:class, 1}], 1} == :lox_lexer.string('class')
      assert {:ok, [{:cond_if, 1}], 1} == :lox_lexer.string('if')
      assert {:ok, [{:cond_else, 1}], 1} == :lox_lexer.string('else')
      assert {:ok, [{true, 1}], 1} == :lox_lexer.string('true')
      assert {:ok, [{false, 1}], 1} == :lox_lexer.string('false')
      assert {:ok, [{:return, 1}], 1} == :lox_lexer.string('return')
      assert {:ok, [{:super, 1}], 1} == :lox_lexer.string('super')
      assert {:ok, [{:this, 1}], 1} == :lox_lexer.string('this')
      assert {:ok, [{:var, 1}], 1} == :lox_lexer.string('var')
      assert {:ok, [{:loop_while, 1}], 1} == :lox_lexer.string('while')
      assert {:ok, [{:loop_for, 1}], 1} == :lox_lexer.string('for')
      assert {:ok, [{:named_fun, 1}], 1} == :lox_lexer.string('fun')
      assert {:ok, [{:reserved_fun_print, 1}], 1} == :lox_lexer.string('print')
    end

    test "scans maximal munch for reserverd words" do
      assert {:ok, [{:identifier, 1, "and_var"}], 1} == :lox_lexer.string('and_var')
      assert {:ok, [{:identifier, 1, "orchid"}], 1} == :lox_lexer.string('orchid')
    end
  end
end
