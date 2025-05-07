# 🧘 Contador de Hábitos Minimalista

App Flutter de seguimiento de hábitos, diseñada para ser ligera, clara y extensible. Aplicando principios de arquitectura SOLID, separación de responsabilidades, pruebas y buenas prácticas modernas.

---

## 📱 Características principales

- ✅ Crear hábitos con nombre, icono y color personalizado
- 🔔 Recordatorio visual opcional con hora
- 💾 Persistencia local con SharedPreferences
- 🌱 Límite de 3 hábitos en versión gratuita (Premium desbloquea ilimitado)
- 🎯 Seguimiento semanal estilo "GitHub contributions"
- 🌀 Vista Premium con tarjetas modernas y porcentaje de progreso
- 📊 Estadísticas semanales y mensuales (Premium)
- 🧼 Reinicio semanal automático
- ⚙️ Pantalla de configuración (activar Premium, borrar todo)

---

## 🧠 Arquitectura

El proyecto sigue principios de arquitectura limpia y SOLID:

```
lib/
├── controllers/         # Lógica de formularios
├── managers/            # Lógica de negocio
├── models/              # Modelo Habit
├── providers/           # Conecta lógica con UI
├── repositories/        # Persistencia de datos
├── screens/             # Pantallas
├── services/            # Diálogos, mensajes, premium
├── widgets/             # Componentes visuales reutilizables
│   ├── premium/         # Componentes visuales exclusivos Premium
└── main.dart            # Punto de entrada
```

---

## 🧪 Pruebas

Pruebas unitarias usando `flutter_test`:

```bash
flutter test
```

Estructura:
```
test/
├── controllers/
├── services/
├── managers/
├── providers/
├── repositories/
```

---

## 🚀 Tecnologías usadas

- Flutter 3.x
- Dart con null safety
- Provider (gestión de estado)
- SharedPreferences
- Google Fonts (Raleway)
- Flutter Test
- fl_chart (gráficos)
- flutter_iconpicker (selección de íconos)

---

## 🙋 Sobre el desarrollo

Este proyecto fue desarrollado como parte de un portafolio educativo. Se utilizó asistencia de herramientas de IA (ChatGPT) para mejorar diseño, refactor y pruebas, mientras se mantenía la comprensión y el control total sobre cada decisión.

---

## 📌 Por hacer

- [ ] Notificaciones locales reales (flutter_local_notifications)
- [ ] Soporte multi-idioma
- [ ] Autenticación y sincronización con la nube
- [ ] Animaciones fluidas entre pantallas
- [ ] Ranking y logros de hábitos

---

## 🧑‍💻 Autor

Thiago Pirez · [Portafolio próximamente]
