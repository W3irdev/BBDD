// Select the database to use.
use('universidad');

// Insert a few documents into the sales collection.
db.getCollection('Persona').insertMany([
    { 'nombre': 'jesus', 'edad': 18, 'dni': '12345678L', 'fechaNacimiento': new Date('2005-03-19') },
    { 'nombre': 'josemi', 'edad': 38, 'dni': '12345669L', 'fechaNacimiento': new Date('2005-02-11') },
    { 'nombre': 'ana', 'edad': 28, 'dni': '12141678L', 'fechaNacimiento': new Date('2005-04-29') },
]);   

db.getCollection('Profesor').insertMany([
    { 'nombre': 'josemi', 'edad': 18, 'dni': '12345669L', 'fechaNacimiento': new Date('2005-02-11') },
]);  

db.getCollection('Alumno').insertMany([
    { 'nombre': 'jesus', 'edad': 18, 'dni': '12345678L', 'fechaNacimiento': new Date('2005-03-19') },
    { 'nombre': 'ana', 'edad': 18, 'dni': '12141678L', 'fechaNacimiento': new Date('2005-04-29') },
]);  

db.getCollection('Asignatura').insertMany([
    { 'nombre': 'base de datos', 'horas semanales': 6, 'creditos': 3},
    { 'nombre': 'programacion', 'horas semanales': 6, 'creditos': 5},
    { 'nombre': 'lenguaje de marcas', 'horas semanales': 3, 'creditos': 3},
]);  
  
//CRUD
//Consultamos la coleccion de personas.
db.Persona.find()
db.Persona.find().sort({edad : -1}) // Esta consulta, devuelve todos los documentos de Persona, ordenados ascendentemente por edad.
db.Persona.find({nombre:"jesus"}) // Esta consulta, devuelve todos los documentos que contenga el nombre jesus.
db.Persona.find({edad:{$gt:18}}) // Esta consulta, devuelve los documentos donde la edad sea mayor que 18.

//Modificacion de colecciones.
db.Persona.replaceOne({_id: ObjectId("6469df6e65334a8e6e4cb285")}, { 'nombre': 'josemi', 'edad': 30, 'dni': '12345669L', 'fechaNacimiento': new Date('1992-07-20') }) 
// Esta linea reemplaza el documento asociado a _id: ObjectId("6468a42e313cdcb4ee483c60") por los valores del siguiente objeto { 'nombre': 'josemi', 'edad': 30, 'dni': '12345669L', 'fechaNacimiento': new Date('1992-07-20') }

db.Asignatura.updateOne({'nombre': 'programacion'},{$set:{'horas semanales': 8}}) // Esta linea actualiza la coleccion asignatura el documento programacion y asigna horas semanales en 8 horas
db.Asignatura.updateOne({'nombre': 'programacion'},{$set:{'profesor': "Jose Manuel"}}) // AÃ±ade el campo profesor a la asignatura de programacion

//Eliminación de documentos y colecciones.
db.Persona.deleteOne({_id: ObjectId("64689ddef0652ba50a9e83bb")}) //Elimina a la persona/documento que tenga el id seleccionado.
db.Persona.deleteMany({edad:{$gt:18}}) //Elimina a las personas/documentos donde la edad sea mayor que 18.

db.Persona.drop() //Elimina la coleccion con el nombre que le pasamos en este caso es persona.