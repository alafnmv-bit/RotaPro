# RotaPro Entregas — pacote preparado para Hostinger

Esta versão foi preparada para uma hospedagem Hostinger que disponibilize **Node.js** e um banco **PostgreSQL** acessível ao aplicativo.

## O que foi ajustado

- Removida a dependência de Docker para produção.
- `server.js` é o arquivo de inicialização do Node.js.
- Frontend separado em `public/index.html`, `public/style.css` e `public/app.js`.
- Configuração por variáveis de ambiente (`.env`/Environment Variables).
- Suporte a `DATABASE_URL` ou às variáveis `PGHOST`, `PGPORT`, `PGDATABASE`, `PGUSER`, `PGPASSWORD`.
- Suporte opcional a SSL do PostgreSQL com `PGSSL=true`.
- Servidor escuta em `0.0.0.0`, adequado para ambientes gerenciados.
- Encerramento seguro do servidor/banco.
- O banco cria as tabelas automaticamente na primeira inicialização e carrega as 131 localidades do `db/seed.sql`.

## Configuração no painel da Hostinger

No ambiente Node.js da Hostinger, aponte o aplicativo para esta pasta e use:

- **Startup file:** `server.js`
- **Node.js:** versão 20 ou superior, quando disponível
- **Build/install:** `npm install`
- **Start:** `npm start`
- **Porta:** use a variável `PORT` fornecida pelo ambiente, quando houver

Configure as variáveis de ambiente:

- `NODE_ENV=production`
- `JWT_SECRET=<uma chave longa e aleatória>`
- `DATABASE_URL=<string de conexão PostgreSQL>`

Ou, em vez de `DATABASE_URL`, use `PGHOST`, `PGPORT`, `PGDATABASE`, `PGUSER`, `PGPASSWORD` e, se necessário, `PGSSL=true`.

## Banco de dados

O banco precisa existir antes da primeira inicialização. Depois de configurar a conexão, o próprio `server.js` executa `db/schema.sql` e `db/seed.sql`.

## Primeiro administrador

Por segurança, o cadastro público cria entregadores. Depois de criar o primeiro usuário entregador, altere seu papel para administrador no PostgreSQL:

```sql
UPDATE users SET role='admin' WHERE phone='SEU_TELEFONE';
```

## HTTPS

Use HTTPS no domínio publicado. Isso é importante para geolocalização GPS e notificações do navegador.

## Importante

A compatibilidade exata depende do plano/ambiente Hostinger contratado. Este pacote não usa Docker em produção e está preparado para o fluxo de hospedagem Node.js + PostgreSQL; se o plano não disponibilizar Node.js ou PostgreSQL, será necessário outro ambiente Hostinger que ofereça esses recursos.
