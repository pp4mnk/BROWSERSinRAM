# BROWSERSinRAM
Quería compartir lo satisfecho que estoy con mi última configuración de XFCE_Fusilli. Después de bastantes pruebas y ajustes, he conseguido que Firefox y Slimjet funcionen exactamente como quiero: rápidos, siempre disponibles y a un solo clic de distancia.  He creado dos pequeños scripts de shell, uno para Firefox y otro para Slimjet,
Inicio automático

En cuanto arranca XFCE_Fusilli, ambos scripts ejecutan automáticamente sus respectivos navegadores utilizando mis lanzadores optimizados para trabajar con RAM.

Los scripts crean directorios temporales en /dev/shm, lo que permite aprovechar la memoria RAM para almacenar archivos temporales y realizar determinadas operaciones del navegador, reduciendo la dependencia del almacenamiento en disco.

2. Ambos navegadores anclados en la bandeja del sistema

Utilizo KDocker junto con xdotool para colocar automáticamente Firefox y Slimjet en la bandeja del sistema (system tray).

De esta manera, ambos navegadores permanecen siempre accesibles, sin llenar el escritorio ni la barra de tareas de ventanas innecesarias.

Basta con hacer clic en el icono correspondiente para recuperar inmediatamente la ventana del navegador.

También he desactivado las notificaciones emergentes de KDocker, para mantener el escritorio limpio y sin distracciones.

3. ¡Navegación web prácticamente instantánea!

Esta es probablemente la característica que más me gusta.

Como ambos navegadores ya están ejecutándose en segundo plano, abrir cualquiera de ellos resulta prácticamente instantáneo.

Nada de esperar a que arranque el navegador ni de soportar pantallas de carga innecesarias. Simplemente hago clic en el icono de la bandeja del sistema y empiezo a navegar.

Naturalmente, no hay ningún truco mágico: los navegadores ya están cargados y preparados para funcionar, y precisamente ahí está la diferencia.

4. Reinicio automático cuando se cierra un navegador

Esta es otra pequeña mejora con la que estoy especialmente satisfecho.

Ambos scripts supervisan continuamente los procesos de sus respectivos navegadores.

Si cierro accidentalmente Firefox o Slimjet por completo, el script correspondiente detecta el cierre y vuelve a ejecutar automáticamente el navegador.

La comprobación de los procesos se realiza aproximadamente cada medio segundo, incorporando una pequeña espera para evitar reinicios innecesarios.

Una vez reiniciado, el navegador vuelve a quedar anclado automáticamente en la bandeja del sistema.

De esta manera, siempre tengo los dos navegadores disponibles y preparados para utilizarlos.

5. Sin instancias duplicadas innecesarias

También he incorporado un sencillo mecanismo de bloqueo para evitar que se ejecuten simultáneamente varias copias del mismo script de supervisión.

Además, los scripts comprueban si el navegador correspondiente ya está funcionando antes de intentar iniciar una nueva instancia.

Así evito procesos de supervisión duplicados y arranques innecesarios.

6. Ligero, sencillo y funcional

Todo funciona mediante scripts de shell convencionales, KDocker y xdotool.

Sin servicios complicados en segundo plano, sin Python y sin dependencias pesadas.

Simplemente un par de pequeños scripts que hacen exactamente lo que necesito.

¿Y cuál es el resultado?

Ahora tengo dos navegadores permanentemente disponibles desde la bandeja del sistema, con almacenamiento temporal en RAM y recuperación automática cuando los cierro.

Para mi navegación diaria, la mejora en comodidad y sensación de rapidez es fantástica.

Y como estamos hablando de Puppy Linux, puedo disfrutar de todas estas ventajas manteniendo un sistema ligero y completamente bajo mi control.

Estoy realmente encantado con el rendimiento que estoy consiguiendo con esta configuración de XFCE_Fusilli.

A veces, las mejores mejoras no consisten en instalar más programas, sino en conseguir que los que ya tenemos funcionen de una manera más inteligente.

¡Rápido, sencillo, práctico... y muy al estilo Puppy! ¡Jajaja!

Adjunto ambos scripts por si alguien quiere probar esta configuración o adaptarla a su propio sistema.
