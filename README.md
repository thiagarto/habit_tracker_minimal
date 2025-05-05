# 🧘 Contador de Hábitos Minimalista

App Flutter de seguimiento de hábitos, diseñada para ser ligera, clara y extensible. Aplicando principios de arquitectura SOLID, separación de responsabilidades, pruebas y buenas prácticas modernas.

---

## 📱 Características principales

- ✅ Crear hábitos con nombre y recordatorio opcional
- 🔔 Recordatorio visual (sin notificaciones nativas aún)
- 💾 Persistencia local con SharedPreferences
- 🌱 Límite de 3 hábitos en versión gratuita (Premium opcional)
- 🎯 Seguimiento semanal tipo "GitHub contributions"
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
├── widgets/             # Componentes visuales
└── main.dart            # Punto de entrada
```

---

## 🧪 Pruebas

Pruebas unitarias y de widgets usando `flutter_test`:

```bash
flutter test
```

Estructura:
```
test/
├── controllers/
├── services/
```

---

## 🚀 Tecnologías usadas

- Flutter 3.x
- Dart null safety
- Provider
- SharedPreferences
- Google Fonts (Raleway)
- Flutter Test

---

## 🙋 Sobre el desarrollo

Este proyecto fue desarrollado como parte de un portafolio educativo. Se utilizó asistencia de herramientas de IA (ChatGPT) para mejorar diseño, refactor y pruebas, mientras se mantenía la comprensión y el control total sobre cada decisión.

---

## 📌 Por hacer

- Notificaciones locales reales
- Soporte multi-idioma
- Autenticación y sincronización con nube
- Estadísticas de hábitos completados

---

## 🧑‍💻 Autor

Thiago Pirez · [Portafolio próximamente]
