# Carga los paquetes necesarios
library(tidyverse)

# Lectura de los datos
pinguinos <- read.table("", header = TRUE)

# Filtra los datos y guarda solamente los de la isla Torgersen
pinguinos_filtrados <- pinguinos %>%
                        filter(species == "Adelie")

# Exporta los datos filtrados
write.table(pinguinos_filtrados, "pinguinos_filtrados.txt",
            sep = "\t",quote = FALSE,row.names = FALSE)

# Grafica cuántos pingüinos de la especie Adelie viven en cada isla.
ggplot(pinguinos_filtrados,aes(x = island, fill = island)) +
    geom_bar() +
    theme_minimal()

# Exporta la gráfica de barras
ggsave("grafica_barras.png", device = "png")

# Genera un heatmap que muestre el número de pinguinos por especie en cada isla
conteo_pinguinos <- pinguinos %>%
                        group_by(species,island) %>%
                        count() %>%
                        spread(island,n) %>%
                        replace(is.na(.), 0)

matriz_pinguinos <- conteo_pinguinos[-1] %>%
                    as.matrix()
rownames(matriz_pinguinos) <- conteo_pinguinos$species

heatmap(matriz_pinguinos)

# Exporta el heatmap
png("heatmap.png")
heatmap(matriz_pinguinos, margins = c(10,10))
dev.off()
