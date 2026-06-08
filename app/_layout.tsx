import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { Colors } from '../constants/Colors';

export default function RootLayout() {
  return (
    <>
      <StatusBar style="light" backgroundColor={Colors.navyDeep} />
      <Stack screenOptions={{ headerShown: false }}>
        <Stack.Screen name="(tabs)" />
        <Stack.Screen
          name="restaurant/[id]"
          options={{
            headerShown: true,
            headerTransparent: true,
            headerTitle: '',
            headerBackTitle: '',
            headerTintColor: Colors.white,
          }}
        />
        <Stack.Screen
          name="cart"
          options={{
            presentation: 'modal',
            headerShown: true,
            headerTitle: 'Your Cart',
            headerStyle: { backgroundColor: Colors.navyDeep },
            headerTitleStyle: { color: Colors.white, fontWeight: '700' },
            headerTintColor: Colors.orange,
          }}
        />
      </Stack>
    </>
  );
}
