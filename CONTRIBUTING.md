# Contribuindo para o LASC OS

Obrigado por considerar contribuir com o LASC OS! 🎉

## Como Contribuir

### Reportar Bugs
1. Verifique se o bug já não foi reportado nas [Issues](https://github.com/[usuario]/lasc-os/issues)
2. Crie uma nova issue com:
   - Descrição clara do problema
   - Passos para reproduzir
   - Comportamento esperado vs atual
   - Screenshots se aplicável
   - Versão do LASC OS
   - Dispositivo/ambiente

### Sugerir Features
1. Verifique se já não existe nas [Discussions](https://github.com/[usuario]/lasc-os/discussions)
2. Abra uma nova discussão explicando:
   - Qual problema resolve
   - Como deveria funcionar
   - Por que é importante

### Pull Requests
1. Fork o projeto
2. Crie uma branch: `git checkout -b feature/MinhaFeature`
3. Faça suas alterações
4. Teste completamente
5. Commit: `git commit -m 'feat: Adiciona MinhaFeature'`
6. Push: `git push origin feature/MinhaFeature`
7. Abra um Pull Request

### Padrões de Código

**Shell Scripts:**
- Use `#!/bin/sh` (POSIX compatible)
- Indentação: 4 espaços
- Variáveis em MAIÚSCULAS
- Funções com nomes descritivos
- Comentários em português

**Commits:**
- Mensagens em português
- Formato: `tipo: descrição`
- Tipos: `feat`, `fix`, `docs`, `style`, `refactor`, `test`

### Testando

Antes de submeter PR:
```bash
# Testar em VM
pmbootstrap qemu --display=none -p 3333

# Testar todos os comandos
lasc-doctor

# Verificar sintaxe dos scripts
shellcheck scripts/*.sh
```

## Código de Conduta

- Seja respeitoso
- Aceite críticas construtivas
- Foque no que é melhor para a comunidade
- Tenha empatia com outros contribuidores

## Dúvidas?

Abra uma [Discussion](https://github.com/[usuario]/lasc-os/discussions) ou entre em contato!

---

**Obrigado por contribuir! 🚀**
