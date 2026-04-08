// Script de prueba para verificar el nuevo algoritmo de asignación de horarios
// Este script simula los datos de entrada y prueba la lógica

const testAlgoritmo = async () => {
    console.log('🧪 INICIANDO PRUEBA DEL NUEVO ALGORITMO');
    
    try {
        // Simular solicitud a API
        const response = await fetch('https://torneojc.onrender.com/api/torneo-activo');
        const torneo = await response.json();
        
        console.log(`✓ Torneo activo: ${torneo.nombre} (ID: ${torneo.id})`);
        
        // Simular configuración de grupos
        const configuracionGrupos = {
            'Categoria-B': { grupos3: 2, grupos4: 1, grupos5: 0 },
            'Categoria-C': { grupos3: 1, grupos4: 1, grupos5: 0 }
        };
        
        console.log(`📋 Configuración de grupos:`, configuracionGrupos);
        
        // Enviar solicitud para armar grupos con el nuevo algoritmo
        const armarResponse = await fetch('https://torneojc.onrender.com/api/armar-grupos', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                configuracionGrupos: configuracionGrupos,
                idTorneo: torneo.id
            })
        });
        
        const resultado = await armarResponse.json();
        
        console.log(`\n📊 RESULTADOS:`);
        console.log(`✅ Grupos generados: ${resultado.grupos.length}`);
        console.log(`⚠️ Partidos totales: ${resultado.partidos.length}`);
        console.log(`❌ Partidos sin horario: ${resultado.partidos.filter(p => !p.horario).length}`);
        
        if (resultado.sin_grupo && resultado.sin_grupo.length > 0) {
            console.log(`👥 Jugadores sin grupo: ${resultado.sin_grupo.length}`);
        }
        
        if (resultado.advertencias && resultado.advertencias.length > 0) {
            console.log(`⚠️ Advertencias: ${resultado.advertencias.length}`);
            
            const tipos = {};
            resultado.advertencias.forEach(adv => {
                tipos[adv.tipo] = (tipos[adv.tipo] || 0) + 1;
            });
            console.log(`📋 Desglose de advertencias:`, tipos);
            
            // Mostrar algunas advertencias específicas
            console.log(`\n🔍 Ejemplos de advertencias:`);
            resultado.advertencias.slice(0, 3).forEach((adv, index) => {
                console.log(`   ${index + 1}. ${adv.mensaje}`);
            });
        }
        
        // Verificar que no hay conflictos de horarios
        const partidosConHorario = resultado.partidos.filter(p => p.horario);
        const conflictos = verificarConflictos(partidosConHorario);
        
        console.log(`\n🔍 ANÁLISIS DE CONFLICTOS:`);
        console.log(`✅ Partidos con horario asignado: ${partidosConHorario.length}`);
        console.log(`❌ Conflictos detectados: ${conflictos.length}`);
        
        if (conflictos.length === 0) {
            console.log(`🎉 ¡ÉXITO! No hay conflictos de horarios`);
        } else {
            console.log(`⚠️ Conflicto detectado - Revisar logs del servidor`);
            conflictos.forEach(conflicto => {
                console.log(`   ❌ ${conflicto}`);
            });
        }
        
        return resultado;
        
    } catch (error) {
        console.error(`❌ Error en prueba:`, error);
        throw error;
    }
};

const verificarConflictos = (partidos) => {
    const conflictos = [];
    const jugadorHorarios = {}; // { jugadorId: Set([horarioId, ...]) }
    const jugadorFechas = {};   // { jugadorId: Set([fecha, ...]) }
    
    partidos.forEach(partido => {
        if (!partido.horario) return;
        
        const { local, visitante, horario } = partido;
        const fecha = horario.fecha;
        const horarioId = horario.id;
        
        // Verificar conflicto de horario exacto
        if (!jugadorHorarios[local]) jugadorHorarios[local] = new Set();
        if (!jugadorHorarios[visitante]) jugadorHorarios[visitante] = new Set();
        
        if (jugadorHorarios[local].has(horarioId)) {
            conflictos.push(`Jugador ${local} ya tiene partido en horario ${horarioId}`);
        }
        if (jugadorHorarios[visitante].has(horarioId)) {
            conflictos.push(`Jugador ${visitante} ya tiene partido en horario ${horarioId}`);
        }
        
        // Verificar conflicto de mismo día
        if (!jugadorFechas[local]) jugadorFechas[local] = new Set();
        if (!jugadorFechas[visitante]) jugadorFechas[visitante] = new Set();
        
        if (jugadorFechas[local].has(fecha)) {
            conflictos.push(`Jugador ${local} ya tiene partido en fecha ${fecha}`);
        }
        if (jugadorFechas[visitante].has(fecha)) {
            conflictos.push(`Jugador ${visitante} ya tiene partido en fecha ${fecha}`);
        }
        
        // Registrar ocupación
        jugadorHorarios[local].add(horarioId);
        jugadorHorarios[visitante].add(horarioId);
        jugadorFechas[local].add(fecha);
        jugadorFechas[visitante].add(fecha);
    });
    
    return conflictos;
};

// Ejecutar prueba
console.log('🚀 INICIANDO PRUEBA DEL ALGORITMO CORREGIDO');
testAlgoritmo().then(() => {
    console.log('\n✅ PRUEBA COMPLETADA');
}).catch(error => {
    console.error('\n❌ PRUEBA FALLÓ:', error);
});