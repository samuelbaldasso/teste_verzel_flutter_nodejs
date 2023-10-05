# Teste Verzel - Flutter / Nodejs

Este é um teste de aptidão para a vaga de Desenvolvedor Fullstack Flutter Pleno na Verzel. Abaixo estarão as informações sobre como utilizar este repositório.

---

## Assets

Acesse esta pasta para saber mais sobre os requisitos da vaga, assim como os requisitos do teste de aptidão.

---

## Instalando na máquina

Basta ir até este repositório no GitHub, apertar no botão Code, copiar o link em HTTPS, ir no seu terminal independente do seu sistema operativo, escolha o diretório desejado, digite o comando git clone + o link copiado e aperte Enter. Depois, vá na sua IDE preferida (de preferência Visual Studio Code) e abra o projeto clonado na mesma.

---

## Instalando VSCode, Flutter e NodeJS

## VsCode

Vá até o link abaixo e siga as instruções do mesmo para instalar o VSCode: 

https://code.visualstudio.com/

Depois, é só abrir a IDE instalada e configurá-la para aceitar o Flutter e Dart. Para isso, instale esta extensão: 

https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter

---

## Flutter

Vá até o link abaixo e siga as instruções nele descritas:

https://docs.flutter.dev/get-started/install

---

## NodeJS

Vá até o link abaixo e instale a versão LTS mais recente:

https://nodejs.org/en

Depois, é só rodar o executável instalado e seu NodeJS estará funcionando.

---

## Backend - NodeJS 

Na sua IDE, abra a pasta vitrine_carros_backend, nela estará o pacote do projeto NodeJS. No seu terminal integrado, vá até o diretório da pasta citada e rode o comando npm install. Isso instalará todas as dependências registradas no projeto. Por fim, para rodar o servidor localmente na porta 3001, rode o comando abaixo: 

nodemon server.js

PS: Para rodar o servidor backend com sucesso, é necessário instalar o SGBD PostgreSQL. Para tal, vá até esse link abaixo e depois rode o exceutável instalado:

https://www.postgresql.org/download/

Agora basta testar o PostgreSQL abrindo-o e logando na senha definida por você na hora da instalação para também abrir o servidor do Postgres, assim como o banco padrão de nome postgres.

PS: Não se preocupe com a criação do banco, o servidor já faz isso automaticamente via Sequelize.

---

## Mobile - Flutter

Na sua IDE, abra a pasta vitrine_carros, nela estará o pacote do projeto Flutter. No seu terminal integrado, vá até o diretório da pasta citada e rode o comando flutter pub get. Isso instalará todas as dependências registradas no projeto. Depois, é necessário já possuir Android Studio com emulador e variáveis de ambiente já configurados. Se ainda não sabe como se faz isso, estude o recurso abaixo:

https://balta.io/blog/flutter-instalacao-configuracao-android-windows#:~:text=Abra%20o%20Android%20Studio%2C%20e,IDE%2C%20aceite%20e%20tudo%20pronto

A partir daí basta apertar a tecla F5 (ou Fn + F5) , escolha seu emulador, aperte Enter e o emulador será inicializado, assim como o app será compilado e executado.

PS: Rode a aplicação backend antes, senão os dados do app não serão servidos e o app não funcionará conforme o esperado!!

---

## Schemas para cadastro de carros e usuários

Siga o padrão desses exemplos abaixo, caso deseje utilizar o Postman ou Insomnia para fins de testes.

## Carros

{
    "marca": "Fiat",
    "modelo": "Uno 1000",
    "ano": 2015,
    "preco": 4000.00,
    "descricao": "Carro extremamente confiável e barato!!",
    "imagem_url": "https://images.prd.kavak.io/eyJidWNrZXQiOiJrYXZhay1pbWFnZXMiLCJrZXkiOiJpbWFnZXMvMjY0MzM3L0VYVEVSSU9SLWZyb250U2lkZVBpbG90TmVhci0xNjkyODM2OTA0NzgyLmpwZWciLCJlZGl0cyI6eyJyZXNpemUiOnsid2lkdGgiOjU0MCwiaGVpZ2h0IjozMTB9fX0="
}

{
    "marca": "Hyundai",
    "modelo": "Creta",
    "ano": 2020,
    "preco": 88899.00,
    "descricao": "Carro extremamente confiável e barato!!",
    "imagem_url": "https://images.prd.kavak.io/eyJidWNrZXQiOiJrYXZhay1pbWFnZXMiLCJrZXkiOiJpbWFnZXMvMjgwMTMwL0VYVEVSSU9SLWZyb250U2lkZVBpbG90TmVhci0xNjk1ODY2MzQwMTM4LmpwZWciLCJlZGl0cyI6eyJyZXNpemUiOnsid2lkdGgiOjU0MCwiaGVpZ2h0IjozMTB9fX0="
}

## Usuários

{
    "email": "samuel@gmail.com",
    "nome": "Samuel Baldasso",
    "senha": "123456",
    "imagem_url": "https://images.prd.kavak.io/eyJidWNrZXQiOiJrYXZhay1pbWFnZXMiLCJrZXkiOiJpbWFnZXMvMjY0MzM3L0VYVEVSSU9SLWZyb250U2lkZVBpbG90TmVhci0xNjkyODM2OTA0NzgyLmpwZWciLCJlZGl0cyI6eyJyZXNpemUiOnsid2lkdGgiOjU0MCwiaGVpZ2h0IjozMTB9fX0="
}

---

## Imagens do app

<img width="379" alt="Captura de tela 2023-10-03 090516" src="https://github.com/samuelbaldasso/teste_verzel_flutter_nodejs/assets/53982121/06446c38-336c-4269-a938-4ca9464c1ecb">

---

<img width="379" alt="Captura de tela 2023-10-03 090431" src="https://github.com/samuelbaldasso/teste_verzel_flutter_nodejs/assets/53982121/55daad99-8fbf-4fe5-bc2e-3dcad6d41d86">

---

<img width="379" alt="Captura de tela 2023-10-03 090414" src="https://github.com/samuelbaldasso/teste_verzel_flutter_nodejs/assets/53982121/61307cfd-a48f-45dc-a8bf-e7567650977c">

---

<img width="379" alt="Captura de tela 2023-10-03 090359" src="https://github.com/samuelbaldasso/teste_verzel_flutter_nodejs/assets/53982121/11c0b51d-b6b4-45b4-befd-f9773d773710">

---

<img width="379" alt="Captura de tela 2023-10-03 090332" src="https://github.com/samuelbaldasso/teste_verzel_flutter_nodejs/assets/53982121/d259a313-7a66-4573-9df5-16c9eee6ca54">

---

Espero que gostem! Para mais informações sobre mim, acessem os links abaixo:

https://github.com/samuelbaldasso

https://www.linkedin.com/in/samuel-baldasso-91903b141/

---
