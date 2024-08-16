theme_electrified <- function(base_size = 12, base_family = "Helvetica") {
    theme_classic() +
    theme(
        legend.position = "top",
        legend.title = element_blank(),
        legend.text = element_text(size=7),
        legend.key.size = unit(.4, "cm"),
        legend.key.spacing.x = unit(.05, "cm"),
        panel.grid.major.y = element_line(color = "gray", size = 0.1), 
        panel.grid.major.x = element_line(color = "gray", size = 0.1)
    )
}