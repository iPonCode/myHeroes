//  AnItemsFactory.swift
//  iListUI
//
//  Created by Simón Aparicio on 25/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

struct AnItemsFactory {

    // Mock data
    static var someItems: [AnItem] = [
        AnItem(image: "imagen01",
                    author: "Pedro Alonso Domínguez",
                    title: "Ingeniería mecánica para pilotos incapacitados por alcoholemia",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoD",
                    popularity: 5,
                    watched: true,
                    favourite: true,
                    featured: true),
        AnItem(image: "imagen08",
                    author: "Antonio Repitorio Del Duplicado",
                    title: "Ingeniería mecánica para pilotos incapacitados por alcoholemia",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoB",
                    popularity: 4,
                    watched: false,
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen02",
                    author: "Eusebio Jiménez Martín",
                    title: "Excavación de túneles anchos para personal no cualificado",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoC",
                    popularity: 1,
                    watched: Bool.random(),
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen03",
                    author: "Eladio Mínguez García",
                    title: "Matemáticas para congresistas en paro",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoA",
                    popularity: 5,
                    watched: false,
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen04",
                    author: "Aitor Guisseppe del Saz",
                    title: "Electromagnetismo fácil para amas de casa aburridas",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoC",
                    popularity: 3,
                    watched: Bool.random(),
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen05",
                    author: "Ignorito Muy Bonito",
                    title: "Curso imprescindible de lengua de signos",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoD",
                    popularity: 2,
                    watched: Bool.random(),
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen06",
                    author: "Alejandra Amaya Dulce",
                    title: "Buenas intenciones en tiempos de cuarentena",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoE",
                    popularity: 5,
                    watched: false,
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen07",
                    author: "Sergio Regio Antón",
                    title: "Velociraptor detenido por circular por debajo de la mínima permitida",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoA",
                    popularity: 3,
                    watched: false,
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen08",
                    author: "Aitor Guisseppe del Saz",
                    title: "Un curso más sobre como doblar camisetas",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoC",
                    popularity: 2,
                    watched: Bool.random(),
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen08",
                    author: "Pedro Alonso Domínguez",
                    title: "Ingeniería mecánica para pilotos incapacitados por alcoholemia",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoD",
                    popularity: 1,
                    watched: Bool.random(),
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen07",
                    author: "Eusebio Jiménez Martín",
                    title: "Excavación de túneles anchos para personal no cualificado",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoE",
                    popularity: 3,
                    watched: false,
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen06",
                    author: "Eladio Mínguez García",
                    title: "Matemáticas para congresistas en paro",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoF",
                    popularity: 5,
                    watched: false,
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen05",
                    author: "Aitor Guisseppe del Saz",
                    title: "Electromagnetismo fácil para amas de casa aburridas",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoB",
                    popularity: 5,
                    watched: false,
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen04",
                    author: "Ignorito Muy Bonito",
                    title: "Curso imprescindible de lengua de signos",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoB",
                    popularity: 1,
                    watched: Bool.random(),
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen03",
                    author: "Alejandra Amaya Dulce",
                    title: "Buenas intenciones en tiempos de cuarentena",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoC",
                    popularity: 4,
                    watched: Bool.random(),
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen02",
                    author: "Sergio Regio Antón",
                    title: "Velociraptor detenido por circular por debajo de la mínima permitida",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoF",
                    popularity: 3,
                    watched: Bool.random(),
                    favourite: Bool.random(),
                    featured: Bool.random()),
        AnItem(image: "imagen01",
                    author: "Aitor Guisseppe del Saz",
                    title: "Un curso más sobre como doblar camisetas",
                    description: RandomDescription(Int.random(in: 0...3)).description,
                    type: "tipoB",
                    popularity: 1,
                    watched: Bool.random(),
                    favourite: Bool.random(),
                    featured: Bool.random())
    ]
    
    /*private*/ enum RandomDescription: Int {
        
        case desc0 = 0
        case desc1 = 1
        case desc2 = 2
        case desc3 = 3
        
        init(_ random: Int) {
            switch random {
            case 0:
                self = .desc0
            case 1:
                self = .desc1
            case 2:
                self = .desc2
            case 3:
                self = .desc3
            default:
                self = .desc0
            }
        }
        
        var description : String {
            switch self {
            case .desc0:
                return """
                Es un hecho establecido hace demasiado tiempo que un lector se distraerá con el contenido del texto de un sitio mientras que mira su diseño. El punto de usar Lorem Ipsum es que tiene una distribución más o menos normal de las letras, al contrario de usar textos como por ejemplo "Contenido aquí, contenido aquí". Estos textos hacen parecerlo un español que se puede leer. Muchos paquetes de autoedición y editores de páginas web usan el Lorem Ipsum como su texto por defecto, y al hacer una búsqueda de "Lorem Ipsum" va a dar por resultado muchos sitios web que usan este texto si se encuentran en estado de desarrollo. Muchas versiones han evolucionado a través de los años, algunas veces por accidente, otras veces a propósito (por ejemplo insertándole humor y cosas por el estilo).
                """
            case .desc1:
                return """
                Al contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio. Tiene sus raices en una pieza cl´sica de la literatura del Latin, que data del año 45 antes de Cristo, haciendo que este adquiera mas de 2000 años de antiguedad. Richard McClintock, un profesor de Latin de la Universidad de Hampden-Sydney en Virginia, encontró una de las palabras más oscuras de la lengua del latín, "consecteur", en un pasaje de Lorem Ipsum, y al seguir leyendo distintos textos del latín, descubrió la fuente indudable. Lorem Ipsum viene de las secciones 1.10.32 y 1.10.33 de "de Finnibus Bonorum et Malorum" (Los Extremos del Bien y El Mal) por Cicero, escrito en el año 45 antes de Cristo. Este libro es un tratado de teoría de éticas, muy popular durante el Renacimiento. La primera linea del Lorem Ipsum, "Lorem ipsum dolor sit amet..", viene de una linea en la sección 1.10.32
                """
            case .desc2:
                return """
                Hay muchas variaciones de los pasajes de Lorem Ipsum disponibles, pero la mayoría sufrió alteraciones en alguna manera, ya sea porque se le agregó humor, o palabras aleatorias que no parecen ni un poco creíbles. Si vas a utilizar un pasaje de Lorem Ipsum, necesitás estar seguro de que no hay nada avergonzante escondido en el medio del texto. Todos los generadores de Lorem Ipsum que se encuentran en Internet tienden a repetir trozos predefinidos cuando sea necesario, haciendo a este el único generador verdadero (válido) en la Internet. Usa un diccionario de mas de 200 palabras provenientes del latín, combinadas con estructuras muy útiles de sentencias, para generar texto de Lorem Ipsum que parezca razonable. Este Lorem Ipsum generado siempre estará libre de repeticiones, humor agregado o palabras no características del lenguaje, etc.
                """
            case .desc3:
                return """
                Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas "Letraset", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum.
                """
            }
        }
    }
    
}
