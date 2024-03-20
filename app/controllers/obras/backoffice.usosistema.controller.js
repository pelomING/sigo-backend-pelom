/***********************************************************************************/
/*                                                                                 */
/*                                                                                 */
/*                                 USO DEL SISTEMA                                */
/*                                                                                 */
/*                                                                                 */
/***********************************************************************************/

// Lista un resumen de los login hechos en el sistema dentro de un período
// GET /api/obras/backoffice/usosistema/v1/alllogin
exports.getAllLoginSistema = async (req, res) => {
/*  #swagger.tags = ['Obras - Backoffice - Uso del Sistema']
      #swagger.description = 'Lista un resumen de los login hechos en el sistema dentro de un período' */
    const salida = [
        {id: 1, fecha: '2024-03-20', cantidad: 10, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 2, fecha: '2024-03-19', cantidad: 13, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 3, fecha: '2024-03-18', cantidad: 5, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 4, fecha: '2024-03-17', cantidad: 0, "bg-color": 'bg-pink-500', "text-color": 'text-pink-500'},
        {id: 5, fecha: '2024-03-16', cantidad: 15, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 6, fecha: '2024-03-15', cantidad: 7, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 7, fecha: '2024-03-14', cantidad: 9, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'}
    ]

    res.status(200).send(salida);
}

// Lista un resumen del ingreso de obras en el sistema en los dias recientes
// GET /api/obras/backoffice/usosistema/v1/resumenobrasrecientes
exports.getObrasIngresadasResumen = async (req, res) => {
/*  #swagger.tags = ['Obras - Backoffice - Uso del Sistema']
      #swagger.description = 'Lista un resumen del ingreso de obras en el sistema en los dias recientes' */
    const salida = [
        {id: 1, fecha: '2024-03-20', cantidad: 2, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 2, fecha: '2024-03-19', cantidad: 0, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 3, fecha: '2024-03-18', cantidad: 4, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 4, fecha: '2024-03-17', cantidad: 0, "bg-color": 'bg-pink-500', "text-color": 'text-pink-500'},
        {id: 5, fecha: '2024-03-16', cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 6, fecha: '2024-03-15', cantidad: 5, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'},
        {id: 7, fecha: '2024-03-14', cantidad: 1, "bg-color": 'bg-cyan-500', "text-color": 'text-cyan-500'}
    ]

    res.status(200).send(salida);
}

// Lista cantidad de obras sin reporte recietes
// GET /api/obras/backoffice/usosistema/v1/resumenobrasinreportes
exports.getObrasSinRepDiario = async (req, res) => {
/*  #swagger.tags = ['Obras - Backoffice - Uso del Sistema']
      #swagger.description = 'Lista cantidad de obras sin reporte recietes' */

    const periodo = {
        desde: '2024-03-13',
        hasta: '2024-03-20'
    };

    const cantidad = 5;

    const detalle = [
        {id: 1, codigo_obra: 'CGED-1234000', fecha_ultimo: '2024-03-20', dias_sin_rep: 2},
        {id: 2, codigo_obra: 'CGED-1113344', fecha_ultimo: '2024-03-01', dias_sin_rep: 17},
        {id: 3, codigo_obra: 'CGED-0098643', fecha_ultimo: '2024-03-15', dias_sin_rep: 5},
        {id: 4, codigo_obra: 'CGED-4362235', fecha_ultimo: '2024-03-18', dias_sin_rep: 2},
        {id: 5, codigo_obra: 'CGED-6841249', fecha_ultimo: '2024-03-12', dias_sin_rep: 8}
    ];

    const salida = {
        periodo: periodo,
        cantidad: cantidad,
        detalle: detalle
    };

    res.status(200).send(salida);
}