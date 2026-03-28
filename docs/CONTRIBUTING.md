# Contribuindo para o LASC OS

Obrigado por considerar contribuir com o LASC OS! Toda contribuição é bem-vinda e valorizada.

---

## Sumário

- [Como Contribuir](#como-contribuir)
- [Reportar Bugs](#reportar-bugs)
- [Sugerir Features](#sugerir-features)
- [Pull Requests](#pull-requests)
- [Padrões de Código](#padroes-de-codigo)
- [Testando](#testando)
- [Código de Conduta](#codigo-de-conduta)

---

## Como Contribuir

Existem várias formas de contribuir com o projeto:

- Reportando bugs via Issues
- Sugerindo novas funcionalidades via Discussions
- Enviando Pull Requests com correções ou melhorias
- Melhorando a documentação
- Compartilhando o projeto

---

## Reportar Bugs

1. Verifique se o bug já não foi reportado nas [Issues](https://github.com/lalberto1985/lasc-os/issues)
2. Crie uma nova issue com as seguintes informações:
   - **Título**: Descrição clara e objetiva
   - **Descrição**: O que aconteceu e o que era esperado
   - **Passos para reproduzir**: Sequência de comandos/ações
   - **Ambiente**: Versão do LASC OS, dispositivo, versão do kernel
   - **Screenshots**: Se aplicável

---

## Sugerir Features

1. Verifique se a ideia já existe nas [Discussions](https://github.com/lalberto1985/lasc-os/discussions)
2. Abra uma nova discussão explicando:
   - Qual problema a feature resolve
   - Como ela deveria funcionar
   - Por que seria útil para outros usuários

---

## Pull Requests

```bash
# 1. Faça um fork do repositório
# 2. Clone seu fork
git clone https://github.com/SEU_USUARIO/lasc-os.git
cd lasc-os

# 3. Crie uma branch descritiva
git checkout -b feature/nova-funcionalidade
# ou
git checkout -b fix/corrige-bug-x

# 4. Faça suas alterações e commit
git add .
git commit -m "feat: adiciona nova funcionalidade X"

# 5. Push para seu fork
git push origin feature/nova-funcionalidade

# 6. Abra um Pull Request no GitHub
```

---

## Padrões de Código

### Shell Scripts

- Use `#!/bin/bash` no shebang
- Compatibilidade POSIX sempre que possível
- Indentação: **4 espaços**
- Variáveis locais em `minusculas`, constantes em `MAIUSCULAS`
- Nomes de funções descritivos em snake_case
- Comentários em português
- Valide entradas do usuário

### Convenção de Commits

Utilize o padrão [Conventional Commits](https://www.conventionalcommits.org/):

```
tipo: descrição curta em português

[corpo opcional com mais detalhes]
```

**Tipos aceitos:**

| Tipo       | Uso                                         |
|------------|---------------------------------------------|
| `feat`     | Nova funcionalidade                         |
| `fix`      | Correção de bug                             |
| `docs`     | Alteração em documentação                   |
| `chore`    | Tarefas de manutenção (refactor, estrutura) |
| `style`    | Formatação, sem mudança de lógica           |
| `test`     | Adição ou correção de testes                |
| `refactor` | Refatoração de código                       |

**Exemplos:**
```
feat: adiciona comando lasc-vpn para gerenciamento de VPN
fix: corrige erro de variável indefinida em lasc-wifi
docs: atualiza INSTALLATION.md com método via Flatpak
chore: move scripts para pasta scripts/
```

---

## Testando

Antes de submeter um PR, certifique-se de:

```bash
# Testar em VM (recomendado)
pmbootstrap qemu --display=none -p 3333

# Executar diagnóstico completo
lasc-doctor

# Verificar sintaxe dos scripts shell
shellcheck scripts/*.sh

# Testar o comando novo manualmente
lasc-[seu-comando]
```

---

## Código de Conduta

- Seja respeitoso com todos os colaboradores
- Aceite críticas construtivas com abertura
- Foque no que é melhor para a comunidade
- Tenha empatia com outros usuários e contribuidores
- Qualquer forma de assédio ou discriminação não será tolerada

---

## Dúvidas?

Abra uma [Discussion](https://github.com/lalberto1985/lasc-os/discussions) ou uma [Issue](https://github.com/lalberto1985/lasc-os/issues) com a tag `question`.

---

**Obrigado por tornar o LASC OS melhor! 🚀**
