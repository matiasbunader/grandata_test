# grandata_test

# PARTE 1

Aclaración: Se utilizaron versiones más recientes de Spark y Python para agilizar el desarrollo del test.

Punto 1:

    Total amount billed by the service provider: $1696075.0

Punto 2:

    File attached in the directory

Punto 3:

    PNG file attached in the directory


# PARTE 2

Punto 1:
    ¿Cómo priorizaría los procesos productivos sobre los procesos de análisis exploratorios?

    - Asignación de colas y prioridades: Configurar colas específicas dentro del cluster para los procesos productivos y los exploratorios, dándole más prioridad a los primeros y asegurando que estos siempre tengan recursos (YARN por ejemplo).

    - Limitación de recursos para análisis exploratorios: Fijar un límite de recursos para asegurarnos de que estos procesos no estén usando recursos de manera exceciva y no perjudique a los procesos productivos. Dentro de esta opción, se puede  evaluar políticas         de acceso y de programación para que estos procesos se ejecuten dependiendo de qué tanto se están usando los recursos del cluster al momento de la ejecución.

    ¿Qué estrategia utilizaría para administrar su ejecución durante el día? ¿Qué herramientas de scheduling conoce para tal fin?

    - Monitoreo que permita supervisar los recursos y entender cuándo y cómo se están consumiendo.

    Herramientas de scheduling que pueden servir en este caso: Apache Airflow, Prefect, Snowflake tasks, Databricks workflows, SAP BW chain process.

Punto 2: 

    ¿Cuáles serían las posibles causas de este problema?

    - Mala indexación o particionamiento ineficiente: Si esto ocurre, para cada consulta probablemente se tenga que escanear toda la tabla en lugar de sólo los datos relevantes a la consulta.

    - Uso de formatos de archivo no óptimos: Parquet y ORC suelen ser más eficientes que CSV o JSON por ejemplo.

    - Consulta poco optimizada, modelado de datos poco eficiente.

    - Método de escritura en la tabla overwrite en vez de delta.

    ¿Qué sugiero para solucionarlo?

    - Optimización del particionamiento, sin que sea excesivo (buscar campos clave como puede ser la fecha)

    - Usar formatos de archivos convenientes (Parquet, ORC, etc) comprimidos.

    - Usar tecnologías como Apache Iceberg, que permite la actualización de datos sin bloqueos.

    - Carga de datos en formato UPSERT, MERGE, etc.

    - Optimización de consultas con spark, por ejemplo usando caché.

Punto 3:

    Configuración de núcleos:

    En la sessión de Spark, configuramos de la siguiente manera:

    --num-executors 9: Dividimos el trabajo en 9 ejecutores, distribuidos en los 3 nodos.
    --executor-cores 2: Cada ejecutor usa 2 cores, lo que da un total de 18 cores (9x2), la mitad de los 36 disponibles.
    --executor-memory 8G: Cada ejecutor tiene 8 GB de memoria, sumando 72 GB (9x8).
    --driver-memory 8G: Memoria asignada al driver para coordinar la ejecución.

    Controlar límites vía archivo yarn-site.xml (maximum-allocation)

    ✔ Memoria: 75 GB asignados a Spark, 75 GB reservados para otros jobs.
    ✔ Cores: 18 cores para Spark, 18 cores libres.
    ✔ Ejecutores: 9 ejecutores con 2 cores y 8 GB cada uno.
    ✔ Control en YARN: Límites establecidos en yarn-site.xml.
    ✔ Evitamos sobreasignación: Se desactiva spark.dynamicAllocation.

Estas configuraciones aseguran que el proceso de Spark no consuma más de la mitad del clúster, dejando los recursos restantes disponibles para otros procesos.

    

    
