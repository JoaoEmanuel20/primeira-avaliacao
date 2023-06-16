programa {
	funcao inicio() {
		import re
coluna = 0
entrada = ''
ch = ''
token = ''


def scanner():
    global coluna
    global ch
    palavra = ''
    if ch == '':
        read()
    if ch != None and ch.isalpha():
        palavra += ch
        read()
        while ch != None and (ch.isdigit() or ch.isalpha()):
            palavra += ch
            read()
    else:
        if ch != None and ch in '+-*/@#!':
            palavra += ch
            read()
        elif ch != None and ch in '({[]})':
            palavra += ch
            read()
        elif ch != None and ch.isdigit():
            palavra += ch
            read()
            while ch != None and ch.isdigit():
                palavra += ch
                read()
            if ch != None and ch.isalpha():
                raise Exception(
                    "Não pode ser iniciado com caracteres inválidos. Tente novamente.")
    print(palavra)
    return None if palavra == '' else palavra


def read():
    global coluna
    global entrada
    global ch
    if coluna < len(entrada):
        ch = entrada[coluna]
        coluna += 1
    else:
        ch = None


def fator():
    global token
    aux_token = token
    if token == "{":
        token = scanner()
        aux_token = expressao_aritmetica()
        if token != "}":
            raise Exception("Expressão aritmetica invalida!")
    elif token == "(":
        token = scanner()
        aux_token = expressao_aritmetica()
        if token != ")":
            raise Exception("Expressão aritmetica invalida!")
    elif token == "[":
        token = scanner()
        aux_token = expressao_aritmetica()
        if token != "]":
            raise Exception("Expressão aritmetica invalida!")
    elif token != None and not token.isalnum():
        raise Exception("Expressão aritmetica invalida!")
    token = scanner()
    return aux_token


def termo_linha():
    global token
    if token != None and token in "*/":
        op = token
        token = scanner()
        fator_token_1 = fator()
        fator_token_2 = termo_linha()
        if fator_token_2 == None:
            return fator_token_1
        else:
            return fator_token_2

    else:
        return None


def termo():
    global token
    fator_token_1 = fator()
    op = token
    fator_token_2 = termo_linha()
    if fator_token_2 == None:
        return fator_token_1
    else:
        return fator_token_2


def expressao_aritmetica_linha():
    global token
    if token != None and token in "+-":
        op = token
        token = scanner()
        termo_token_1 = termo()
        termo_token_2 = expressao_aritmetica_linha()
        if termo_token_2 == None:
            return termo_token_1
        else:
            return termo_token_2
    else:
        return None


def expressao_aritmetica():
    global token
    termo_token_1 = termo()
    op = token
    termo_token_2 = expressao_aritmetica_linha()
    if termo_token_2 == None:
        return termo_token_1
    else:
        return termo_token_2


def parser():
    global token
    token = scanner()
    expressao_aritmetica()


entrada = input("Digite uma palavra: ")[:10]
# while True:
#     if entrada[0].isdigit() or entrada[0] in '+-*/':
#         break
#     else:
#         print("Não pode ser iniciado com caracteres inválidos. Tente novamente.")

regex = re.compile(
    r'^[+\-/]?\d+(\.\d+)?([+\-/]\d+(\.\d+)?)([+\-/]\(\d+(\.\d+)?\))?([+\-/]\d+(\.\d+)?)$')

parser()
print("Compilador aceitou.")
# if regex.match(entrada):
# else:
#     print("Entrada inválida.")

	}
}
