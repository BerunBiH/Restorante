# Restorante

This is a project I did for my University. It's a restaurant app that has a mobile and a desktop component. 

The app was made using .NET and Flutter. The mobile app supports Android while the desktop client supports Windows. It's also possible to run the app on iOS on the mobile part and on Linux for the desktop part but those platforms were not the primary focus while developing the app.

The mobile app allows users to brows different dishes, create orders, reservations and view their user profile, while the desktop app allows the staff to look at the orders, tag them as done or not, put out new dishes and drinks, and manage the reservations.

The mobile app is aimed for the standard users while the desktop app is aimed for the admins.

To run the project you need to set up the backend API environment and frontend environment.

## Setting up

### Before setting up the environments you need to make sure that you have:
- [Docker installed and running](https://www.docker.com/)
- [Rabbit MQ installed](https://www.rabbitmq.com/docs/install-windows#installer)
- Flutter
- An Android Emulator like Android Studio

### First you need to set up the API environment which you do in these steps:
- Clone the repository from github
- `https://github.com/BerunBiH/Restorante.git`
- Open the main project folder

  ![image](https://github.com/user-attachments/assets/deeb25bf-e1a9-4d6f-9e37-ab33f9364074)

  
- Add the provided .env file to the folder

![image](https://github.com/user-attachments/assets/9cddaf4d-b518-4a25-b63f-5af7a484d9ce)

  
- Type in the command:
- `docker compose up`
- Wait for docker to finish composing

If you want to check only the API endpoints you can open [Swagger](http://localhost:5266/swagger/index.html)

### After the API is set up and is running you can open the eRestoranteUI folder and choose eather the erestorante_desktop folder or the erestorante_mobile folder

![image](https://github.com/user-attachments/assets/56cd9683-0a96-491d-817f-73639fd2d88c)


### If you choose the erestorante_desktop follow these steps:
- If you are on widnows enable Developer mode
- Open an IDE of your choice
- Install all required dependencies:
- `flutter pub get`
- Run the app
- `flutter run -d windows`

### If you choose the erestorante_mobile follow these steps:
- Open an IDE of your choice
- Install all required dependencies:
- `flutter pub get`
- Run an Android Virutual Device from an Android Emulator
- Run the app
- `flutter run`

## CREDENTIALS
For the desktop app use these credentials:
`email: admin.admin@gmail.com`
`password: admin`

For the mobile app use these credentials:
`email: korisnik.korisnik@gmail.com`
`password: korisnik`

For the PayPal payment use these credentials:
`email: rs2.personal@gmail.com`
`password: ;2&c7&C3`

## WARNINGS
Setting up the app can take a few minutes. The docker compose up command can take up to 3-4 minutes, while also the flutter run command can take 3-4 minutes if it's run on a slower machine, so have patience :)

PayPal is in German because my account is a german one, so that is not a bug.

## LICENSE
This whole project is for my university so it has an Apache-2.0 licese which you can feel free to use.
